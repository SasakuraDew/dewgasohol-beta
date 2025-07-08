<template>
  <v-container class="register-bg">
    <v-row justify="center">
      <v-col cols="12" sm="8" md="6">
        <v-card color="white">
          <v-card-title class="text-h5 black--text">ลงทะเบียนผู้ใช้งาน</v-card-title>
          <v-card-text>
            <v-form ref="registrationForm" v-model="valid" @submit.prevent="submitForm">
              <v-text-field
                v-model="form.name"
                label="ชื่อ"
                :rules="[rules.required]"
                required
                class="black--text"
              ></v-text-field>

              <v-text-field
                v-model="form.email"
                label="อีเมล"
                :rules="[rules.required, rules.email]"
                required
                class="black--text"
              ></v-text-field>

              <v-text-field
                v-model="form.password"
                label="รหัสผ่าน"
                :type="showPassword ? 'text' : 'password'"
                :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                @click:append="showPassword = !showPassword"
                :rules="[rules.required, rules.minPassword]"
                required
                class="black--text"
              ></v-text-field>

              <v-text-field
                v-model="form.confirmPassword"
                label="ยืนยันรหัสผ่าน"
                :type="showConfirmPassword ? 'text' : 'password'"
                :append-icon="showConfirmPassword ? 'mdi-eye' : 'mdi-eye-off'"
                @click:append="showConfirmPassword = !showConfirmPassword"
                :rules="[rules.required, rules.passwordMatch]"
                required
                class="black--text"
              ></v-text-field>

              <v-radio-group v-model="form.gender" label="เพศ" :rules="[rules.required]" row required class="black--text mb-4">
                <v-radio label="ชาย" value="male" class="black--text"></v-radio>
                <v-radio label="หญิง" value="female" class="black--text"></v-radio>
                <v-radio label="อื่น ๆ" value="other" class="black--text"></v-radio>
              </v-radio-group>

              <v-select
                v-model="form.interests"
                :items="interestOptions"
                label="ความสนใจ"
                multiple
                chips
                :rules="[rules.minInterests]"
                required
                class="black--text"
              ></v-select>

              <v-btn color="success" type="submit" class="mt-4 black--text" block>ลงทะเบียน</v-btn>
            </v-form>

            <v-alert v-if="registrationSuccess" type="success" class="mt-4 black--text">
              ลงทะเบียนสำเร็จ!
            </v-alert>
            <div v-if="showVideo" class="mt-4">
              <iframe width="100%" height="315" :src="videoUrl" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      valid: false,
      showPassword: false,
      showConfirmPassword: false,
      form: {
        name: '',
        email: '',
        password: '',
        confirmPassword: '',
        gender: null,
        interests: [],
      },
      interestOptions: [
        'กีฬา',
        'ดนตรี',
        'ภาพยนตร์',
        'หนังสือ',
        'เทคโนโลยี',
        'ท่องเที่ยว',
        'ทำอาหาร',
      ],
      registrationSuccess: false,
      showVideo: false,
      videoUrl: '',
      rules: {
        required: value => !!value || 'กรุณากรอกข้อมูล',
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || 'รูปแบบอีเมลไม่ถูกต้อง';
        },
        minPassword: value => value && value.length >= 6 || 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร',
        passwordMatch: value => value === this.form.password || 'รหัสผ่านไม่ตรงกัน',
        minInterests: value => value && value.length > 0 || 'กรุณาเลือกความสนใจอย่างน้อยหนึ่งอย่าง',
      },
    };
  },
  methods: {
    async submitForm() {
      const valid = await this.$refs.registrationForm.validate();
      if (valid) {
        this.registrationSuccess = true;
        this.showVideo = true;
        this.videoUrl = 'https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1';
      } else {
        this.registrationSuccess = false;
        this.showVideo = false;
        this.videoUrl = '';
      }
    },
  },
};
</script>

<style scoped>
.register-bg {
  background: #fff !important;
  min-height: 100vh;
}
.v-card, .v-text-field, .v-radio, .v-select, .v-btn, .v-alert {
  color: #222 !important;
}
</style>