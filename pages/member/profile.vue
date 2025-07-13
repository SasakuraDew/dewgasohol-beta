<template>
  <v-container class="py-8" style="max-width: 500px; margin: 0 auto;">
    <v-card>
      <v-card-title class="headline">โปรไฟล์สมาชิก</v-card-title>
      <v-divider></v-divider>
      <v-card-text>
        <v-row align="center" justify="center">
          <v-avatar size="100">
            <v-img src="/This is number 357.jpg"></v-img>
          </v-avatar>
        </v-row>
        <v-row class="mt-4">
          <v-col cols="4" class="font-weight-bold">ชื่อ-สกุล:</v-col>
          <v-col cols="8">เปิ้ลนาคร</v-col>
        </v-row>
        <v-row>
          <v-col cols="4" class="font-weight-bold">อีเมล:</v-col>
          <v-col cols="8">triggerbutbossfirst@outlook.com</v-col>
        </v-row>
        <v-row>
          <v-col cols="4" class="font-weight-bold">เบอร์โทร:</v-col>
          <v-col cols="8">081-234-5678</v-col>
        </v-row>
        <v-row>
          <v-col cols="4" class="font-weight-bold">ที่อยู่:</v-col>
          <v-col cols="8">123/45 หมู่ 6 ต.ตัวอย่าง อ.เมือง จ.กรุงเทพฯ 10000</v-col>
        </v-row>
        <v-row>
          <v-col cols="4" class="font-weight-bold">คำอธิบาย:</v-col>
          <v-col cols="8">ลูก 357 นี่หว่า ลูกนี้ซื้อมาจากร้านเฮียฮงหลังดิโอลด์สยาม ไอนี้มือปืนมีนายเว้ย เด็กซุ้มแน่นอน</v-col>
        </v-row>
      </v-card-text>
      <v-card-actions>
        <v-btn color="primary" outlined>แก้ไขข้อมูล</v-btn>
      </v-card-actions>
    </v-card>
  </v-container>
</template>

<script>
export default {
  name: 'ProfilePage'
}
</script>

<style scoped>
.font-weight-bold {
  font-weight: bold;
}
</style>
