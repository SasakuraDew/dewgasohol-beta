<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="12" sm="10" md="8">
        <v-card class="mt-5">
          <v-list-item three-line>
            <v-list-item-content>
              <div class="overline mb-4">โปรไฟล์</div>
              <v-list-item-title class="headline mb-1">
                {{ loggedInUser ? loggedInUser.displayName : 'N/A' }}
              </v-list-item-title>
              <v-list-item-subtitle>{{ loggedInUser ? loggedInUser.email : 'N/A' }}</v-list-item-subtitle>
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

            <v-divider inset></v-divider>

            <v-list-item>
              <v-list-item-icon>
                <v-icon>mdi-information-outline</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title style="white-space: normal;">
                  ลูก 357 นี่หว่า ลูกนี้ซื้อมาจากร้านเฮียฮงหลังดิโอลด์สยาม ไอนี้มือปืนมีนายเว้ย เด็กซุ้มแน่นอน
                </v-list-item-title>
                <v-list-item-subtitle>คำอธิบาย</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
          </v-list>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" outlined>
              <v-icon left>mdi-pencil</v-icon>
              แก้ไขข้อมูล
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  middleware: 'auth',
  name: 'ProfilePage',
  computed: {
    ...mapGetters('auth', ['loggedInUser'])
  },
  // Note: In a real application, the phone, address, and description
  // would also be fetched from your backend and managed in the store.
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