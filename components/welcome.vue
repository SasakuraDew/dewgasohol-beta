<template>
    <v-container class="fill-height white-theme" fluid>
        <v-row align="center" justify="center">
            <v-col cols="12" md="8" lg="6">
                <v-card class="elevation-12 pa-5 text-center white-theme-card" color="white">
                    <img src="/1994408.jpg" alt="welcome" style="width:100px; height:100px; object-fit:cover; margin-bottom:16px; border-radius:50%; border:2px solid #eee; background:#fff;" />
                    <h1 class="mb-2" style="color:#222;">ยินดีต้อนรับ!</h1>
                    <p class="mb-4" style="color:#444;">
                        ขอบคุณที่เข้ามาใช้งานเว็บไซต์ของเรา<br>
                        ขอให้คุณมีวันที่ดี!
                    </p>
                    <v-btn color="white" class="black--text">
                        เริ่มต้นใช้งาน
                    </v-btn>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
export default {
    name: 'Welcome',
}
</script>

<style scoped>
.fill-height {
    min-height: 100vh;
    background: #fff;
}
.white-theme {
    background: #fff !important;
}
.white-theme-card {
    background: #fff !important;
    color: #222;
    border: 1px solid #eee;
}
</style>