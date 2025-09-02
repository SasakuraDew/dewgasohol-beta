<template>
    <div class="home-bg">
        <v-container>
            <v-row >
                <!-- ตลาดหุ้น -->
                <v-col cols="12" md="4">
                    <v-card color="white">
                        <v-card-title class="black--text">
                            <v-icon left color="green">mdi-chart-line</v-icon>
                            ตลาดหุ้นวันนี้
                        </v-card-title>
                        <v-card-text>
                            <v-list dense light app>
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
                    <v-card color="white">
                        <v-card-title class ="black--text">
                            <v-icon left color="orange">mdi-fuel</v-icon>
                            ราคาน้ำมันล่าสุด
                        </v-card-title>
                        <v-card-text>
                            <v-list dense light app>
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
                    <v-card color="white">
                        <v-card-title class="black--text">
                            <v-icon left color="blue">mdi-laptop</v-icon>
                            ข่าวเทคโนโลยีคอมพิวเตอร์
                        </v-card-title>
                        <v-card-text>
                            <v-list dense light app>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>AI กำลังเปลี่ยนแปลงโลกธุรกิจ</v-list-item-title>
                                        <v-list-item-subtitle>บริษัทใหญ่เริ่มนำ AI มาใช้ในกระบวนการทำงาน</v-list-item-subtitle>
                                    </v-list-item-content>
                                </v-list-item>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>เปิดตัวชิปประมวลผลรุ่นใหม่</v-list-item-title>
                                        <v-list-item-subtitle>ประสิทธิภาพสูงขึ้น 30% เมื่อเทียบกับรุ่นก่อน</v-list-item-subtitle>
                                    </v-list-item-content>
                                </v-list-item>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title>Cloud Computing โตต่อเนื่อง</v-list-item-title>
                                        <v-list-item-subtitle>องค์กรขนาดใหญ่หันมาใช้คลาวด์มากขึ้น</v-list-item-subtitle>
                                    </v-list-item-content>
                                </v-list-item>
                            </v-list>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
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
            apiKey:'023PY4D7PLBL210Q' // ใส่ API Key ของ Alpha Vantage ที่นี่
        }
    },
    methods: {
        async fetchStockData() {
            try {
                // Alpha Vantage API: GLOBAL_QUOTE for SET Index (symbol: SET.BK)
                const url = `https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=SET.BK&apikey=${this.apiKey}`;
                const setRes = await axios.get(url);
                // Response ตัวอย่าง: { "Global Quote": { "05. price": "1600.25", "10. change percent": "0.32%" } }
                const quote = setRes.data["Global Quote"];
                if (quote && quote["05. price"]) {
                    this.stockData.setIndex = `${quote["05. price"]} (${quote["10. change percent"]})`;
                } else {
                    this.stockData.setIndex = 'ไม่พบข้อมูล';
                }
            } catch (e) {
                this.stockData.setIndex = 'ไม่สามารถโหลดข้อมูล';
            }
            // NASDAQ/NIKKEI: สามารถเพิ่ม API จริงได้
        }
    },
    mounted() {
        this.fetchStockData();
        this.intervalId = setInterval(this.fetchStockData, 30000);
    },
    beforeDestroy() {
        if (this.intervalId) clearInterval(this.intervalId);
    }
}
</script>

<style scoped>
.home-bg {
    background: #fff !important;
    min-height: 100vh;
}
v-container, v-row, v-col, v-card {
    position: relative;
    z-index: 2;
}
</style>