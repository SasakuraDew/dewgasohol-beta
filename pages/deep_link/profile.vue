<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="12" sm="10" md="8">
        <!-- Admin Console Section -->
        <v-card class="mt-5 mb-5" v-if="isAdmin">
          <v-card-title class="headline blue--text text--darken-2">
            <v-icon left color="blue darken-2">mdi-security</v-icon>
            Admin Console
          </v-card-title>
          <v-card-text>
            ยินดีต้อนรับ Super Admin. คุณสามารถเข้าถึงส่วนควบคุมพิเศษได้จากที่นี่
          </v-card-text>
          <v-card-actions>
            <v-btn text color="blue darken-2">จัดการผู้ใช้</v-btn>
            <v-btn text color="blue darken-2">ดูสถิติ</v-btn>
          </v-card-actions>
        </v-card>

        <!-- User Profile Section -->
        <v-card>
          <v-list-item three-line>
            <v-list-item-content>
              <div class="overline mb-4">โปรไฟล์</div>
              <v-list-item-title class="headline mb-1">
                <!-- Corrected to use display_name -->
                {{ loggedInUser ? loggedInUser.display_name : 'N/A' }}
              </v-list-item-title>
              <v-list-item-subtitle>{{ loggedInUser ? loggedInUser.email : 'N/A' }}</v-list-item-subtitle>
              <v-list-item-subtitle class="font-weight-bold mt-2 success--text" v-if="isAdmin">{{ loggedInUser.position }}</v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-avatar tile size="100">
              <v-img src="/This is number 357.jpg"></v-img>
            </v-list-item-avatar>
          </v-list-item>

          <v-divider></v-divider>

          <v-list>
            <v-list-item>
              <v-list-item-icon>
                <v-icon>mdi-phone</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>081-234-5678</v-list-item-title>
                <v-list-item-subtitle>เบอร์โทร</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>

            <v-divider inset></v-divider>

            <v-list-item>
              <v-list-item-icon>
                <v-icon>mdi-map-marker</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>123/45 หมู่ 6 ต.ตัวอย่าง อ.เมือง จ.กรุงเทพฯ 10000</v-list-item-title>
                <v-list-item-subtitle>ที่อยู่</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
          </v-list>

          <v-card-actions>
            <v-btn color="primary" outlined>
              <v-icon left>mdi-pencil</v-icon>
              แก้ไขข้อมูล
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn color="error" @click="logout">
              <v-icon left>mdi-logout</v-icon>
              ออกจากระบบ
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'ProfilePage',
  computed: {
    ...mapGetters('auth', ['loggedInUser']),
    isAdmin() {
      return this.loggedInUser && this.loggedInUser.position === 'admin';
    }
  },
  methods: {
    ...mapActions('auth', ['logout']), // Map the logout action from the store
    logout() {
      // The original logout action in the store clears localStorage and commits the mutation.
      // We just need to call it and then redirect.
      this.$store.dispatch('auth/logout');
      // เพิ่มการลบข้อมูล user ออกจาก localStorage
      localStorage.removeItem('auth_user');
      this.$router.push('/deep_link/user_signin');
    }
  }
}
</script>

<style scoped>
.v-card {
  border-radius: 16px;
}
.v-list-item__title {
  font-weight: 500;
}
</style>
