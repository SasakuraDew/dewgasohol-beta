
<template>
  <v-container class="d-flex flex-column align-center justify-center" style="height: 80vh;">
    <v-card width="450" elevation="8" class="pa-6">
      <v-card-title class="justify-center">
        <h1>ยินดีต้อนรับ</h1>
      </v-card-title>
      <v-card-text class="text-center">
        <v-btn color="primary" class="ma-2" to="/about">ข้อมูล</v-btn>
        <v-btn color="success" class="ma-2" to="/register">สมัครสมาชิก</v-btn>
        <v-btn color="info" class="ma-2" to="/login">เข้าสู่ระบบ</v-btn>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import Welcome from '~/components/welcome.vue';
export default {
  name: 'HomePage',
  components: {
    Welcome
  }
};
</script>