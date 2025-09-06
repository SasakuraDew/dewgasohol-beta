<template>
  <v-app>
  <!-- Banner moved to center above devices -->
    <v-main style="background-color: #f5f5f5; min-height: 100vh;">
   
      <v-container fluid class="d-flex flex-column align-center fill-height" style="min-height: 100vh;">
        <!-- <div class="wokwi-banner-center">Wokwi Get DHT22</div> -->
        <div class="d-flex flex-row justify-center align-center w-100">
        <v-card
          class="pa-6 d-flex flex-column align-center mx-4"
          max-width="350"
          outlined
          style="border-radius: 18px; box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.15);"
        >
          <v-card-title class="justify-center align-center flex-column" style="width: 100%;">
            <span class="text-h5 font-weight-bold">DHT22 Client</span>
            <span class="caption grey--text">(ตัวที่ 1 ค่าอุณหภูมิมาจากตัวแปร temperature ใน data())</span>
          </v-card-title>
          <v-card-text class="text-center">
            <img src="/otronic-temperature-and-humidity.jpg" alt="DHT22 Sensor" style="max-width: 80%; height: auto; margin: 32px 0 24px 0;">
            <div class="text-h4 mb-2 grey--text text--darken-2">
              อุณหภูมิ: <span class="font-weight-bold">{{ temperature }} °C</span>
            </div>
            <div class="text-h5 grey--text text--darken-1">
              ความชื้น: <span class="font-weight-medium">{{ humidity }} %</span>
            </div>
          </v-card-text>
        </v-card>
        <v-card
          class="pa-6 d-flex flex-column align-center mx-4"
          max-width="350"
          outlined
          style="border-radius: 18px; box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.15);"
        >
          <v-card-title class="justify-center align-center flex-column" style="width: 100%;">
            <span class="text-h5 font-weight-bold">DHT22 Wokwi</span>
            <span class="caption grey--text">(ตัวที่ 2 รับจาก PHP ภายในเครื่อง ที่ได้ API จาก wokwi)</span>
          </v-card-title>
          <v-card-text class="text-center">
            <img src="/wokwi_dht22.png" alt="DHT22 Sensor" style="max-width: 80%; height: auto; margin: 32px 0 24px 0;">
            <div class="text-h4 mb-2 grey--text text--darken-2">
              อุณหภูมิ: <span class="font-weight-bold">{{ temperature }} °C</span>
            </div>
            <div class="text-h5 grey--text text--darken-1">
              ความชื้น: <span class="font-weight-medium">{{ humidity }} %</span>
            </div>
          </v-card-text>
        </v-card>
        </div>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
export default {
  // layout: 'iot_layout' // หากคุณมี layout แยกสำหรับหน้านี้
  name: 'DHT22Page',
  data() {
    return {
      temperature: 25.5, // ตัวอย่างข้อมูลอุณหภูมิ
      humidity: 60,      // ตัวอย่างข้อมูลความชื้น
    };
  },
  mounted() {
    // ส่วนนี้เป็นการจำลองการรับข้อมูลจาก Sensor
    // ในการใช้งานจริง คุณจะต้องเชื่อมต่อกับ API หรือ WebSocket เพื่อรับข้อมูล
    this.updateDataInterval = setInterval(() => {
      // สุ่มค่าอุณหภูมิระหว่าง 20.0 ถึง 30.0
      this.temperature = (Math.random() * (30 - 20) + 20).toFixed(1);
      // สุ่มค่าความชื้นระหว่าง 50 ถึง 70
      this.humidity = Math.floor(Math.random() * (70 - 50) + 50);
    }, 5000); // อัปเดตทุก 5 วินาที
  },
  beforeDestroy() {
    // หยุดการอัปเดตข้อมูลเมื่อออกจากหน้านี้ เพื่อป้องกัน memory leak
    clearInterval(this.updateDataInterval);
  }
};
</script>

<style scoped>
.v-main {
  min-height: 100vh;
}
.v-container {
  min-height: 100vh;
}
.v-card {
  /* เพิ่มเงาและความโค้งมนให้ดูเหมือน boot logo windows 10 */
  box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.15);
  border-radius: 18px;
}
/* กรอบข้อความตรงกลางด้านบน */
.wokwi-banner-center {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 32px;
  margin-top: 32px;
  background: #fff;
  border: 2px solid #1976d2;
  color: #1976d2;
  border-radius: 8px;
  padding: 8px 32px;
  font-weight: bold;
  font-size: 1.2rem;
  box-shadow: 0 2px 8px rgba(25, 118, 210, 0.08);
  z-index: 10;
}
</style>