<template>
    <div class="news-bg">
        <v-container>
            <v-row>
                <v-col cols="12" md="8" class="mx-auto">
                    <v-card color="white" class="mb-4">
                        <v-img
                            src="https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=800&q=80"
                            height="300px"
                        ></v-img>
                        <v-card-title class="headline black--text">
                            เทคโนโลยีคอมพิวเตอร์ช่วยเพิ่มประสิทธิภาพการใช้น้ำมันในยุคดิจิทัล
                        </v-card-title>
                        <v-card-subtitle class="grey--text text--darken-1">
                            10 มิถุนายน 2567 | โดย ทีมข่าวเทคโนโลยี
                        </v-card-subtitle>
                        <v-card-text class="black--text">
                            <p>
                                ในยุคปัจจุบัน เทคโนโลยีคอมพิวเตอร์เข้ามามีบทบาทสำคัญในการพัฒนาน้ำมันเชื้อเพลิง ทั้งในด้านการวิจัยสูตรน้ำมันใหม่ ๆ และการควบคุมคุณภาพการผลิต
                                ระบบคอมพิวเตอร์ช่วยให้โรงกลั่นน้ำมันสามารถตรวจสอบและปรับปรุงกระบวนการผลิตได้อย่างแม่นยำ ส่งผลให้ประหยัดพลังงานและลดต้นทุน
                            </p>
                            <p>
                                นอกจากนี้ ระบบ IoT และ AI ยังถูกนำมาใช้ในการบริหารจัดการสถานีบริการน้ำมัน เพื่อวิเคราะห์ข้อมูลการใช้งานและคาดการณ์ความต้องการของผู้บริโภค
                                ทำให้สามารถจัดสรรทรัพยากรได้อย่างมีประสิทธิภาพมากยิ่งขึ้น
                            </p>
                        </v-card-text>
                        <v-card-actions>
                            <v-btn color="black" text>อ่านเพิ่มเติม</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>

<script>
export default {
    name: "NewsPage",
};
</script>

<style scoped>
.news-bg {
    background: #fff !important;
    min-height: 100vh;
    width: 100vw;
}
</style>