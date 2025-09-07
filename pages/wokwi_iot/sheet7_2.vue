<template>
  <div class="parallax-container">
    <div class="parallax-background"></div>
    <div class="content-section">
      <div class="moving-row">
        <v-card
          class="pa-6 d-flex flex-column align-center mx-4 moving-card"
          max-width="350"
          outlined
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
          class="pa-6 d-flex flex-column align-center mx-4 moving-card"
          max-width="350"
          outlined
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
    </div>
  </div>
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
.parallax-container {
  position: relative;
  width: 100%;
  min-height: 100vh;
}
.parallax-background {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-image: url('https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=2070&auto=format&fit=crop');
  background-size: cover;
  background-position: center;
  z-index: 1;
}
.content-section {
  position: relative;
  z-index: 2;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
}
.moving-row {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 100vw;
}
.moving-card {
  box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.15);
  border-radius: 18px;
  background: rgba(255,255,255,0.95);
}
</style>