<template>
    <div class="parallax-container">
        <div class="parallax-background"></div>
        <div class="content-section">
            <v-container class="py-12">
                <v-row justify="center">
                    <v-col cols="12" md="8" lg="6">
                        <v-card>
                            <v-card-title class="vintage">
                                ติดต่อเรา
                            </v-card-title>
                            <v-card-text>
                                <v-form>
                                    <v-text-field label="ชื่อของคุณ" required prepend-icon="mdi-account"></v-text-field>
                                    <v-text-field label="อีเมล" required prepend-icon="mdi-email" type="email"></v-text-field>
                                    <v-text-field label="เบอร์โทรศัพท์" prepend-icon="mdi-phone" type="tel"></v-text-field>
                                    <v-textarea label="ข้อความ" required prepend-icon="mdi-message" rows="4"></v-textarea>
                                    <v-btn color="primary" class="mt-4" block>ส่งข้อความ</v-btn>
                                </v-form>
                            </v-card-text>
                        </v-card>
                        <v-card class="mt-6">
                            <v-card-title class="subtitle-1">ข้อมูลติดต่อ</v-card-title>
                            <v-card-text>
                                <div><v-icon left>mdi-map-marker</v-icon>123 ถนนสุขุมวิท, กรุงเทพฯ 10110</div>
                                <div><v-icon left>mdi-phone</v-icon>02-123-4567</div>
                                <div><v-icon left>mdi-email</v-icon>info@example.com</div>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
            </v-container>
        </div>
    </div>
</template>
<style scoped>
.parallax-container {
    position: relative;
    width: 100vw;
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
</style>

<script>
export default {
    name: 'ContactPage',
}
</script>