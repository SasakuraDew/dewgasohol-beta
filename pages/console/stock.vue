<template>
  <v-container fluid>
    <v-row>
      <v-col cols="12">
        <h1 class="text-h4">ภาพรวมสต๊อกน้ำมัน</h1>
      </v-col>
    </v-row>

    <!-- Oil Stock Summary Cards -->
    <v-row>
      <v-col
        v-for="fuel in fuelStocks"
        :key="fuel.id"
        cols="12"
        sm="6"
        md="4"
        lg="2"
      >
        <v-card>
          <v-card-title class="d-flex justify-space-between">
            <span>{{ fuel.name }}</span>
            <v-chip small :color="getAlertColor(fuel.percentage, fuel.name)">
              {{ fuel.percentage.toFixed(1) }}%
            </v-chip>
          </v-card-title>
          <v-card-text class="text-center">
            <div class="tank-visualization my-3">
              <div class="tank-body">
                <div
                  class="fuel-level"
                  :style="{ height: fuel.percentage + '%', backgroundColor: getAlertColor(fuel.percentage, fuel.name) }"
                ></div>
              </div>
            </div>
            <p class="text-h5 font-weight-bold">{{ fuel.currentLiters.toLocaleString() }} ลิตร</p>
            <v-progress-linear
              :value="fuel.percentage"
              :color="getAlertColor(fuel.percentage, fuel.name)"
              height="20"
              striped
              class="mt-2"
            >
              <strong class="white--text">{{ fuel.percentage.toFixed(1) }}%</strong>
            </v-progress-linear>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <!-- Stock Management & History -->
    <v-row>
      <v-col cols="12">
        <v-card>
          <v-card-title>
            ประวัติการเบิก-เติม
            <v-spacer></v-spacer>
            <v-btn color="primary" class="mr-2" @click="openTransactionDialog('add')">
              <v-icon left>mdi-plus</v-icon> เติมน้ำมัน
            </v-btn>
            <v-btn color="warning" class="mr-2" @click="openTransactionDialog('withdraw')">
              <v-icon left>mdi-minus</v-icon> เบิกน้ำมัน
            </v-btn>
             <v-btn color="info" @click="editMode = !editMode">
              <v-icon left>mdi-pencil</v-icon> แก้ไขข้อมูล
            </v-btn>
          </v-card-title>
          <v-card-text>
            <v-data-table
              :headers="historyHeaders"
              :items="transactionHistory"
              :items-per-page="10"
              class="elevation-1"
            ></v-data-table>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <!-- Reports and Export -->
    <v-row>
        <v-col cols="12">
            <v-card>
                <v-card-title>รายงาน</v-card-title>
                <v-card-text>
                    <v-row align="center">
                        <v-col cols="12" md="4">
                            <v-menu
                                ref="dateMenu"
                                v-model="dateMenu"
                                :close-on-content-click="false"
                                transition="scale-transition"
                                offset-y
                                min-width="auto"
                            >
                                <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                    v-model="dateRangeText"
                                    label="เลือกระยะเวลา"
                                    prepend-icon="mdi-calendar"
                                    readonly
                                    v-bind="attrs"
                                    v-on="on"
                                ></v-text-field>
                                </template>
                                <v-date-picker
                                v-model="dateRange"
                                range
                                ></v-date-picker>
                            </v-menu>
                        </v-col>
                        <v-col cols="12" md="8">
                            <v-btn color="success" class="mr-2">
                                <v-icon left>mdi-file-excel</v-icon> Export to Excel
                            </v-btn>
                            <v-btn color="error">
                                <v-icon left>mdi-file-pdf-box</v-icon> Export to PDF
                            </v-btn>
                        </v-col>
                    </v-row>
                </v-card-text>
            </v-card>
        </v-col>
    </v-row>

  </v-container>
</template>

<script>
export default {
  middleware: 'admin-auth',
  layout: 'console',
  data() {
    return {
      editMode: false, // Assume manager role for now
      fuelStocks: [
        { id: 1, name: 'แก๊สโซฮอล์ 95', currentLiters: 15000, capacityLiters: 20000 },
        { id: 2, name: 'แก๊สโซฮอล์ 91', currentLiters: 8000, capacityLiters: 20000 },
        { id: 3, name: 'ดีเซล B7', currentLiters: 25000, capacityLiters: 30000 },
        { id: 4, name: 'ดีเซลพรีเมียม', currentLiters: 2500, capacityLiters: 15000 },
        { id: 5, name: 'E20', currentLiters: 1800, capacityLiters: 10000 },
        { id: 6, name: 'E85', currentLiters: 800, capacityLiters: 10000 },
      ].map(fuel => ({
        ...fuel,
        percentage: (fuel.currentLiters / fuel.capacityLiters) * 100,
      })),
      historyHeaders: [
        { text: 'วันที่', value: 'date' },
        { text: 'รายการ', value: 'type' },
        { text: 'ชนิดน้ำมัน', value: 'fuelName' },
        { text: 'ปริมาณ (ลิตร)', value: 'amount', align: 'end' },
        { text: 'คงเหลือ (ลิตร)', value: 'remaining', align: 'end' },
      ],
      transactionHistory: [],
      dateMenu: false,
      dateRange: [],
    };
  },
  computed: {
    dateRangeText () {
      return this.dateRange.join(' ~ ')
    },
  },
  mounted() {
    this.fetchTransactionHistory();
  },
  methods: {
    async fetchTransactionHistory() {
      try {
        const res = await fetch('http://localhost/dewgasohol_beta/tank_stock.php');
        const data = await res.json();
        this.transactionHistory = data.map(item => ({
          date: item.updated_at || '',
          type: item.last_action || '',
          fuelName: item.fuel_type || '',
          amount: item.last_amount ? (item.last_action === 'เติม' ? '+' : '-') + Number(item.last_amount).toLocaleString() : '',
          remaining: item.current_volume ? Number(item.current_volume).toLocaleString() : '',
        }));
      } catch (e) {
        // error
      }
    },
    getAlertColor(percentage, fuelName) {
      if (fuelName === 'แก๊สโซฮอล์ 95') return '#ff9800';
      if (fuelName === 'ดีเซล B7') return 'primary';
      if (percentage < 10) return 'red';
      if (percentage < 30) return 'yellow';
      return 'green';
    },
    openTransactionDialog(type) {
      alert(`เปิดหน้าต่างสำหรับ "${type === 'add' ? 'เติม' : 'เบิก'}น้ำมัน"`);
    },
  },
};
</script>

<style scoped>
.tank-visualization {
  display: inline-block;
  width: 80px;
  height: 120px;
  border: 3px solid #333;
  border-radius: 10px;
  position: relative;
  background-color: #f0f0f0;
  overflow: hidden;
}

.tank-body {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column-reverse;
}

.fuel-level {
  width: 100%;
  transition: height 0.5s ease-in-out, background-color 0.5s ease-in-out;
}

.v-card-title {
    font-size: 1rem;
}
</style>
