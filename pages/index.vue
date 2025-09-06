<template>
  <div class="parallax-container">
    <!-- ส่วนของพื้นหลังที่จะถูกตรึงไว้ -->
    <div class="parallax-background"></div>

    <!-- ส่วนของเนื้อหาที่จะเลื่อนได้ -->
    <div class="content-section">
      <v-container>
        <!-- Hero Section -->
        <v-row align="center" justify="center" class="hero-section text-center">
          <v-col cols="12">
            <h1 class="display-2 font-weight-bold white--text text-shadow">
              รู้จักกับเรา
            </h1>
            <p class="headline white--text text-shadow mt-4">
              ขับเคลื่อนทุกชีวิตด้วยพลังแห่งอนาคต
            </p>
          </v-col>
        </v-row>

        <!-- Icon Section -->
        <v-row justify="center" class="icon-section">
          <v-col v-for="item in iconItems" :key="item.title" cols="6" sm="4" md="2" class="text-center">
            <v-avatar color="rgba(255, 255, 255, 0.2)" size="100" class="mb-4 icon-avatar">
              <v-icon :color="item.color" size="50">{{ item.icon }}</v-icon>
            </v-avatar>
            <h3 class="white--text font-weight-medium">{{ item.title }}</h3>
          </v-col>
        </v-row>

        <!-- ส่วนของการ์ดข้อมูล (โค้ดเดิมของคุณ) -->
        <v-row class="data-cards-section">
          <!-- ตลาดหุ้น -->
          <v-col cols="12" md="4">
            <v-card color="rgba(255, 255, 255, 0.9)">
              <v-card-title class="black--text">
                <v-icon left color="green">mdi-chart-line</v-icon>
                ตลาดหุ้นวันนี้
              </v-card-title>
              <v-card-text>
                <v-list dense light>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>SET Index</v-list-item-title>
                      <v-list-item-subtitle>{{ stockData.setIndex }}</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>NASDAQ</v-list-item-title>
                      <v-list-item-subtitle>{{ stockData.nasdaq }}</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>NIKKEI</v-list-item-title>
                      <v-list-item-subtitle>{{ stockData.nikkei }}</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
              </v-card-text>
            </v-card>
          </v-col>

          <!-- ราคาน้ำมัน -->
          <v-col cols="12" md="4">
            <v-card color="rgba(255, 255, 255, 0.9)">
              <v-card-title class="black--text">
                <v-icon left color="orange">mdi-fuel</v-icon>
                ราคาน้ำมันล่าสุด
              </v-card-title>
              <v-card-text>
                <v-list dense light>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>เบนซิน 95</v-list-item-title>
                      <v-list-item-subtitle>38.50 บาท/ลิตร</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>ดีเซล</v-list-item-title>
                      <v-list-item-subtitle>32.00 บาท/ลิตร</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>แก๊สโซฮอล์ E20</v-list-item-title>
                      <v-list-item-subtitle>34.00 บาท/ลิตร</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
              </v-card-text>
            </v-card>
          </v-col>

          <!-- ข่าวเทคโนโลยีคอมพิวเตอร์ -->
          <v-col cols="12" md="4">
            <v-card color="rgba(255, 255, 255, 0.9)">
              <v-card-title class="black--text">
                <v-icon left color="blue">mdi-laptop</v-icon>
                ข่าวเทคโนโลยี
              </v-card-title>
              <v-card-text>
                <v-list dense light>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>AI กำลังเปลี่ยนแปลงโลก</v-list-item-title>
                      <v-list-item-subtitle>บริษัทใหญ่เริ่มนำ AI มาใช้</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>เปิดตัวชิปประมวลผลใหม่</v-list-item-title>
                      <v-list-item-subtitle>ประสิทธิภาพสูงขึ้น 30%</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item>
                    <v-list-item-content>
                      <v-list-item-title>Cloud Computing โตต่อเนื่อง</v-list-item-title>
                      <v-list-item-subtitle>องค์กรขนาดใหญ่หันมาใช้คลาวด์</v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>
                </v-list>
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
        
        <!-- Dummy content to make page scrollable -->
        <v-row>
            <v-col cols="12">
                <v-card class="pa-5 mt-10" color="rgba(255, 255, 255, 0.9)">
                    <v-card-title>เนื้อหาเพิ่มเติม</v-card-title>
                    <v-card-text>
                        ส่วนนี้ถูกเพิ่มเข้ามาเพื่อให้หน้าเว็บมีความยาวเพียงพอที่จะแสดงผลเอฟเฟกต์ Parallax Scrolling ได้อย่างชัดเจน เมื่อคุณเลื่อนหน้าจอลงมา จะเห็นว่าพื้นหลังยังคงอยู่ที่เดิม แต่เนื้อหาส่วนนี้และส่วนอื่นๆ จะเลื่อนขึ้นมาทับแทนที่
                        <br/><br/>
                        คุณสามารถเพิ่มเนื้อหา, รูปภาพ, หรือคอมโพเนนต์อื่นๆ ของ Vuetify ลงในส่วนนี้ได้ตามต้องการ เพื่อทำให้หน้าเว็บของคุณสมบูรณ์ยิ่งขึ้น
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
      </v-container>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
    name: 'HomePage',
    data() {
        return {
            stockData: {
                setIndex: 'กำลังโหลด...',
                nasdaq: '13,500.75 (+45.30)',
                nikkei: '29,800.10 (-120.50)'
            },
            intervalId: null,
            apiKey: '023PY4D7PLBL210Q', // ใส่ API Key ของ Alpha Vantage ที่นี่
            iconItems: [
                { title: 'วิสัยทัศน์', icon: 'mdi-flag-variant', color: 'white' },
                { title: 'ความยั่งยืน', icon: 'mdi-leaf', color: 'white' },
                { title: 'นวัตกรรม', icon: 'mdi-lightbulb-on-outline', color: 'white' },
                { title: 'องค์กร', icon: 'mdi-office-building', color: 'white' },
                { title: 'ติดต่อเรา', icon: 'mdi-map-marker-outline', color: 'white' },
            ]
        }
    },
    methods: {
        async fetchStockData() {
            try {
                // Alpha Vantage API: GLOBAL_QUOTE for SET Index (symbol: SET.BK)
                const url = `https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=SET.BK&apikey=${this.apiKey}`;
                const setRes = await axios.get(url);
                const quote = setRes.data["Global Quote"];
                if (quote && quote["05. price"]) {
                    this.stockData.setIndex = `${parseFloat(quote["05. price"]).toFixed(2)} (${parseFloat(quote["10. change percent"]).toFixed(2)}%)`;
                } else {
                    this.stockData.setIndex = 'ไม่พบข้อมูล';
                }
            } catch (e) {
                this.stockData.setIndex = 'ไม่สามารถโหลดข้อมูล';
            }
        }
    },
    mounted() {
        this.fetchStockData();
        this.intervalId = setInterval(this.fetchStockData, 60000); // 1 minute interval
    },
    beforeDestroy() {
        if (this.intervalId) clearInterval(this.intervalId);
    }
}
</script>

<style scoped>
.parallax-container {
  position: relative;
  width: 100%;
  min-height: 100vh;
  /* overflow-y: auto; ทำให้ component นี้มี scrollbar ของตัวเอง */
}

.parallax-background {
  position: fixed; /* คีย์สำคัญ: ตรึงพื้นหลังไว้กับ viewport */
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  /* แก้ไข URL ของรูปภาพตามที่คุณต้องการ */
  background-image: url('https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=2070&auto=format&fit=crop');
  background-size: cover;
  background-position: center;
  z-index: 1; /* ทำให้พื้นหลังอยู่ด้านหลังสุด */
}

.content-section {
  position: relative; /* ทำให้เนื้อหาลอยอยู่เหนือพื้นหลัง */
  z-index: 2; /* ทำให้ z-index สูงกว่าพื้นหลัง */
  padding-top: 50px;
  padding-bottom: 50px;
}

.hero-section {
  height: 60vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.text-shadow {
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
}

.icon-section {
    margin-top: -80px; /* ดึง section icon ขึ้นมาเล็กน้อย */
    margin-bottom: 80px;
}

.icon-avatar {
    border: 3px solid white;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.icon-avatar:hover {
    transform: scale(1.1);
    box-shadow: 0px 0px 20px rgba(255, 255, 255, 0.5);
    cursor: pointer;
}

.data-cards-section {
  padding-top: 20px;
}

/* เพิ่มความโปร่งใสให้ v-list เพื่อให้เห็นพื้นหลัง */
.v-list {
    background-color: transparent !important;
}
</style>
