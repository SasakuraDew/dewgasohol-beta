
<template>
  <v-container class="d-flex justify-center align-center" style="height: 80vh;">
    <v-card width="400" elevation="8">
      <v-card-title class="justify-center">เข้าสู่ระบบสมาชิก</v-card-title>
      <v-card-text>
        <v-form @submit.prevent="login">
          <v-text-field
            v-model="email"
            label="อีเมล"
            type="email"
            prepend-icon="mdi-email"
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
          <v-btn color="primary" type="submit" block>เข้าสู่ระบบ</v-btn>
        </v-form>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  data() {
    return { email: '', password: '' }
  },
  methods: {
    login() {
      if (this.email === 'user@test.com' && this.password === '1234') {
        this.$store.commit('setUser', { role: 'member', email: this.email })
        this.$router.push('/member/dashboard')
      } else {
        alert('Login ไม่สำเร็จ')
      }
    }
  }
}
</script>
