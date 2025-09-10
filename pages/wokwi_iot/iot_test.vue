<template>
  <div class="parallax-container">
    <div class="parallax-background"></div>

    <div class="content-section">
      <v-container>
        <v-row align="center" justify="center" class="hero-section text-center">
          <v-col cols="12">
            <h1 class="display-2 font-weight-bold white--text text-shadow">
              Sensor Monitoring Dashboard
            </h1>
            <p class="headline white--text text-shadow mb-2" style="margin-bottom: 12px;">
              Real-time Temperature & Humidity Data
            </p>
          </v-col>
        </v-row>

        <v-row class="data-section">
          <v-col cols="12">
            <v-card class="mb-4 card-transparent">
              <v-card-title class="d-flex justify-space-between align-center">
                <span class="white--text">เพิ่มข้อมูล Sensor</span>
                <v-btn color="white" @click="dialog = true">เพิ่มข้อมูล</v-btn>
              </v-card-title>
            </v-card>

            <v-dialog v-model="dialog" max-width="500px">
                <v-card>
                  <v-card-title class="headline">เพิ่มข้อมูล Sensor</v-card-title>
                  <v-card-text>
                    <v-form ref="form" v-model="formValid" lazy-validation>
                      <v-row>
                        <v-col cols="12" sm="6">
                          <v-text-field v-model="form.temperature" label="Temperature (°C)" type="number" :rules="[v => !!v || 'กรุณากรอกอุณหภูมิ']" required></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6">
                          <v-text-field v-model="form.humidity" label="Humidity (%)" type="number" :rules="[v => !!v || 'กรุณากรอกความชื้น']" required></v-text-field>
                        </v-col>
                      </v-row>
                    </v-form>
                  </v-card-text>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn text @click="dialog = false">ยกเลิก</v-btn>
                    <v-btn color="primary" :disabled="!formValid || inserting" @click="handleInsert">บันทึก</v-btn>
                  </v-card-actions>
                </v-card>
            </v-dialog>

            <v-card class="mb-4 card-transparent">
              <v-card-title class="white--text">Sensor Data Chart</v-card-title>
              <v-card-text>
                <SensorLineChart v-if="sensorData.length > 0" :chart-data="chartData" :options="chartOptions" style="height: 400px" />
                <div v-else class="text-center pa-5 white--text">
                  ไม่มีข้อมูลสำหรับแสดงผลในกราฟ
                </div>
              </v-card-text>
            </v-card>

            <v-card class="card-transparent">
              <v-card-title class="white--text">Sensor Data Table</v-card-title>
              <v-data-table
                :headers="headers"
                :items="sensorData"
                :loading="loading"
                class="elevation-1"
                dark 
              >
                <template v-slot:item.created_at="{ item }">
                  {{ new Date(item.created_at).toLocaleString() }}
                </template>
              </v-data-table>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </div>
  </div>
</template>

<script>
// ====================================
// ส่วนที่ถูกต้องสำหรับ vue-chartjs v3.x + chart.js v2.x
import { Line, mixins } from 'vue-chartjs'
import Chart from 'chart.js'
const { reactiveProp } = mixins

const SensorLineChart = {
  extends: Line,
  mixins: [reactiveProp],
  props: ['chartData', 'options'],
  mounted () {
    this.renderChart(this.chartData, this.options)
  },
  watch: {
    chartData (val) {
      this.renderChart(val, this.options)
    }
  }
}

export default {
  middleware: 'auth',
  components: {
    SensorLineChart
  },
  data() {
    return {
      sensorData: [],
      loading: false,
      inserting: false,
      dialog: false,
      formValid: false,
      form: {
        temperature: '',
        humidity: ''
      },
      headers: [
        { text: 'ID', value: 'id' },
        { text: 'Temperature (°C)', value: 'temperature' },
        { text: 'Humidity (%)', value: 'humidity' },
        { text: 'Created At', value: 'created_at' }
      ],
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: 'top',
            labels: {
                color: 'white' // เปลี่ยนสีข้อความ Legend เป็นสีขาว
            }
          },
          title: {
            display: true,
            text: 'Temperature & Humidity Over Time',
            color: 'white' // เปลี่ยนสี Title เป็นสีขาว
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
                color: 'white' // เปลี่ยนสีตัวเลขแกน Y
            },
            grid: {
                color: 'rgba(255, 255, 255, 0.2)' // เปลี่ยนสีเส้น Grid
            }
          },
          x: {
            ticks: {
                color: 'white' // เปลี่ยนสีตัวเลขแกน X
            },
            grid: {
                color: 'rgba(255, 255, 255, 0.2)' // เปลี่ยนสีเส้น Grid
            }
          }
        }
      }
    }
  },
  computed: {
    chartData() {
      const sortedData = [...this.sensorData].sort((a, b) => new Date(a.created_at) - new Date(b.created_at));
      const labels = sortedData.map(item => new Date(item.created_at).toLocaleTimeString('th-TH'));
      const tempData = sortedData.map(item => item.temperature);
      const humidData = sortedData.map(item => item.humidity);

      return {
        labels: labels,
        datasets: [
          {
            label: 'Temperature (°C)',
            backgroundColor: '#FFA726', // สีส้ม
            borderColor: '#FFA726',
            data: tempData,
            tension: 0.1
          },
          {
            label: 'Humidity (%)',
            backgroundColor: '#66BB6A', // สีเขียว
            borderColor: '#66BB6A',
            data: humidData,
            tension: 0.1
          }
        ]
      }
    }
  },
  mounted() {
    this.fetchSensorData();
  },
  methods: {
    async fetchSensorData() {
      this.loading = true;
      try {
        // **สำคัญ**: แก้ไข URL นี้เป็น API Endpoint ของคุณ
        const res = await this.$axios.get('http://localhost/dewgasohol_beta/sensor_select.php');
        this.sensorData = res.data;
      } catch (e) {
        this.sensorData = [];
      }
      this.loading = false;
    },
    handleInsert() {
      if (!this.$refs.form.validate()) return;
      this.insertSensorData();
    },
    async insertSensorData() {
      this.inserting = true;
      try {
        const payload = {
          temperature: this.form.temperature,
          humidity: this.form.humidity
        };
        // **สำคัญ**: แก้ไข URL นี้เป็น API Endpoint ของคุณ
        const res = await this.$axios.post('http://localhost/dewgasohol_beta/sensor_insert.php', payload);
        if (res.data && res.data.success) {
          this.$refs.form.reset();
          this.$nextTick(() => {
            this.form.temperature = '';
            this.form.humidity = '';
            this.$refs.form.resetValidation();
          });
          await this.fetchSensorData();
          this.dialog = false;
        } else {
          alert('เพิ่มข้อมูลไม่สำเร็จ');
        }
      } catch (e) {
        alert('เกิดข้อผิดพลาดในการเชื่อมต่อ');
      }
      this.inserting = false;
    }
  }
}
</script>

<style scoped>
.parallax-container {
  position: relative;
  width: 100%;
  min-height: 100vh;
}

.parallax-background {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  /* 3. เปลี่ยน URL ของรูปภาพตรงนี้ */
  background-image: url('/wefd.jpg');
  background-size: cover;
  background-position: center;
  z-index: 1; 
}

.content-section {
  position: relative; 
  z-index: 2; 
  padding-top: 10px;
  padding-bottom: 10px;
}

.hero-section {
  height: 20vh; /* ลดความสูงของส่วนหัวข้อ */
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding-bottom: 0;
}

.text-shadow {
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
}

.data-section {
  padding-top: 8px;
}


.card-transparent {
  background-color: rgba(0, 0, 0, 0.589) !important;
  backdrop-filter: blur(2px);
  -webkit-backdrop-filter: blur(2px);
}

/* ทำให้พื้นหลังของ DataTable โปร่งใสเมื่อใช้ theme dark */
.v-data-table.theme--dark {
    background-color: transparent !important;
}
</style>