<template>
  <div class="parallax-container">
    <div class="parallax-background"></div>
    <v-container class="content-section">
      <!-- Hero Title -->
      <v-row justify="center" class="text-center my-8">
        <v-col cols="12">
          <h1 class="display-2 font-weight-bold white--text text-shadow">
            ติดต่อเรา (Contact Us)
          </h1>
          <p class="headline white--text text-shadow mt-4">
            เราพร้อมรับฟังความคิดเห็นและตอบทุกข้อสงสัยของคุณ
          </p>
        </v-col>
      </v-row>

      <!-- Main Content -->
      <v-row justify="center">
        <v-col cols="12" md="11" lg="10">
          <v-card>
            <v-row no-gutters>
              <!-- Left Column: Info, Form, Social -->
              <v-col cols="12" md="5" class="pa-6 pa-md-8">
                <!-- Contact Info -->
                <section>
                  <h2 class="text-h5 font-weight-bold mb-6">ข้อมูลการติดต่อ</h2>
                  <div class="d-flex align-start mb-5">
                    <v-icon color="blue-grey darken-2" left large>mdi-map-marker</v-icon>
                    <div>
                      <strong class="text-subtitle-1">ที่อยู่:</strong><br>
                      <span class="body-1">123 ถนนวิภาวดี กรุงเทพฯ</span>
                    </div>
                  </div>
                  <div class="d-flex align-start mb-5">
                    <v-icon color="blue-grey darken-2" left large>mdi-phone</v-icon>
                    <div>
                      <strong class="text-subtitle-1">โทร:</strong><br>
                      <span class="body-1">02-123-4567</span>
                    </div>
                  </div>
                  <div class="d-flex align-start mb-5">
                    <v-icon color="blue-grey darken-2" left large>mdi-email</v-icon>
                    <div>
                      <strong class="text-subtitle-1">Email:</strong><br>
                      <span class="body-1">support@oilstation.com</span>
                    </div>
                  </div>
                  <div class="d-flex align-start mb-5">
                    <v-icon color="blue-grey darken-2" left large>mdi-clock-outline</v-icon>
                    <div>
                      <strong class="text-subtitle-1">เวลาทำการ:</strong><br>
                      <span class="body-1">08.00 – 20.00 น.</span>
                    </div>
                  </div>
                </section>

                <v-divider class="my-8"></v-divider>

                <!-- Contact Form -->
                <section>
                  <h2 class="text-h5 font-weight-bold mb-6">ฟอร์มติดต่อเรา</h2>
                  <v-form ref="form" v-model="valid">
                    <v-text-field
                      v-model="form.name"
                      :rules="[rules.required]"
                      label="ชื่อ-นามสกุล"
                      outlined
                      prepend-inner-icon="mdi-account"
                    ></v-text-field>
                    <v-text-field
                      v-model="form.email"
                      :rules="[rules.required, rules.email]"
                      label="อีเมล"
                      outlined
                      prepend-inner-icon="mdi-email"
                    ></v-text-field>
                    <v-text-field
                      v-model="form.phone"
                      label="เบอร์โทร"
                      outlined
                      prepend-inner-icon="mdi-phone"
                    ></v-text-field>
                    <v-select
                      v-model="form.subject"
                      :items="['แจ้งปัญหา', 'สอบถามข้อมูลทั่วไป', 'เสนอแนะบริการ', 'อื่นๆ']"
                      :rules="[rules.required]"
                      label="หัวข้อ"
                      outlined
                      prepend-inner-icon="mdi-format-list-bulleted"
                    ></v-select>
                    <v-textarea
                      v-model="form.message"
                      :rules="[rules.required]"
                      label="ข้อความ"
                      outlined
                      rows="4"
                      prepend-inner-icon="mdi-comment-text"
                    ></v-textarea>
                    <v-btn :disabled="!valid" color="primary" block large @click="submit">
                      ส่งข้อความ
                    </v-btn>
                  </v-form>
                </section>

                <v-divider class="my-8"></v-divider>

                <!-- Social Icons -->
                <section class="text-center">
                   <v-btn icon large href="https://facebook.com" target="_blank" class="mx-2">
                     <v-icon size="32px">mdi-facebook</v-icon>
                   </v-btn>
                   <v-btn icon large href="https://line.me" target="_blank" class="mx-2">
                     <v-icon size="32px">mdi-chat-processing</v-icon>
                   </v-btn>
                   <v-btn icon large href="https://instagram.com" target="_blank" class="mx-2">
                     <v-icon size="32px">mdi-instagram</v-icon>
                   </v-btn>
                </section>
              </v-col>

              <!-- Right Column: Map -->
              <v-col cols="12" md="7" class="d-none d-md-block pa-0">
                 <iframe
                   src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3875.297023398826!2d100.55802517594158!3d13.761595196683113!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x30e29e7a5511c379%3A0x372a68b34c7944b1!2sVibhavadi%20Rangsit%20Rd%2C%20Bangkok%2C%20Thailand!5e0!3m2!1sen!2sus!4v1678886476539!5m2!1sen!2sus"
                   width="100%"
                   height="100%"
                   style="border:0;"
                   allowfullscreen=""
                   loading="lazy"
                   referrerpolicy="no-referrer-when-downgrade"
                 ></iframe>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  name: 'ContactPage',
  data: () => ({
    valid: false,
    form: {
      name: '',
      email: '',
      phone: '',
      subject: 'แจ้งปัญหา',
      message: '',
    },
    rules: {
      required: value => !!value || 'กรุณากรอกข้อมูล',
      email: value => {
        const pattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
        return pattern.test(value) || 'อีเมลไม่ถูกต้อง'
      },
    },
  }),
  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        // Replace with your actual form submission logic
        console.log('Form submitted:', this.form);
        alert('ได้รับข้อความของคุณแล้ว! (นี่คือการจำลองการส่งข้อมูล)');
        this.$refs.form.reset();
      }
    },
  },
}
</script>

<style scoped>
.parallax-container {
  position: relative;
  width: 100%;
  min-height: 100vh;
  padding-top: 64px; /* Adjust if you have a fixed toolbar */
  background-color: rgba(4, 0, 255, 0.144);
}
.content-section {
  position: relative;
  z-index: 1; /* Changed from 2 to 1 */
}
.text-shadow {
  text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.7);
}
</style>