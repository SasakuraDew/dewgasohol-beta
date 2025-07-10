
<template>
  <v-container class="d-flex justify-center align-center" style="height: 80vh;">
    <v-card width="400" elevation="8">
      <v-card-title class="justify-center">สมัครสมาชิก</v-card-title>
      <v-card-text>
        <v-form @submit.prevent="register">
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
          <v-btn color="primary" type="submit" block>สมัคร</v-btn>
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
    register() {
      // ส่งข้อมูลไป backend หรือ mock ไปก่อน
      alert(`สมัครสมาชิก: ${this.email}`)
    }
  }
}
</script>