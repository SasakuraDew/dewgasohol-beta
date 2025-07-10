
<template>
  <v-container class="d-flex justify-center align-center" style="height: 80vh;">
    <v-card width="400" elevation="8">
      <v-card-title class="justify-center">เข้าสู่ระบบผู้ดูแล (Admin)</v-card-title>
      <v-card-text>
        <v-form @submit.prevent="login">
          <v-text-field
            v-model="username"
            label="ชื่อผู้ใช้ผู้ดูแล"
            prepend-icon="mdi-account"
            outlined
            dense
            required
          />
          <v-text-field
            v-model="password"
            label="รหัสผ่าน"
            type="password"
            prepend-icon="mdi-lock"
            outlined
            dense
            required
          />
          <v-btn color="primary" type="submit" block>เข้าสู่ระบบผู้ดูแล</v-btn>
        </v-form>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  data() {
    return { username: '', password: '' }
  },
  methods: {
    login() {
      // ตัวอย่าง: username = admin, password = admin
      if (this.username === 'admin' && this.password === 'admin') {
        this.$store.commit('setUser', { role: 'admin', email: this.username })
        this.$router.push('/admin/dashboard')
      } else {
        alert('รหัสไม่ถูกต้อง')
      }
    }
  }
}
</script>