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
            ยินดีต้อนรับ Admin. คุณสามารถเข้าถึงส่วนควบคุมพิเศษได้จากที่นี่
          </v-card-text>
          <v-card-actions>
            <v-btn v-if="isAdmin" to="/console/users" text color="blue darken-2">จัดการผู้ใช้</v-btn>
            <v-btn text color="blue darken-2">ดูสถิติ</v-btn>
          </v-card-actions>
        </v-card>

        <!-- User Profile Section -->
        <v-card v-if="loggedInUser">
          <v-card-title class="d-flex align-center">
            <v-avatar size="100" class="mr-4">
              <v-img :src="loggedInUser.profile_image_url || '/This is number 357.jpg'"></v-img>
            </v-avatar>
            <div>
              <div class="headline">{{ loggedInUser.display_name }}</div>
              <div class="subtitle-1">{{ loggedInUser.fullname }}</div>
            </div>
          </v-card-title>
          <v-divider></v-divider>
          <v-list dense>
            <v-list-item v-if="loggedInUser.position">
              <v-list-item-icon><v-icon>mdi-briefcase</v-icon></v-list-item-icon>
              <v-list-item-content>
                <v-list-item-subtitle>ตำแหน่ง</v-list-item-subtitle>
                <v-list-item-title>{{ loggedInUser.position }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item v-if="loggedInUser.address">
              <v-list-item-icon><v-icon>mdi-map-marker</v-icon></v-list-item-icon>
              <v-list-item-content>
                <v-list-item-subtitle>ที่อยู่</v-list-item-subtitle>
                <v-list-item-title>{{ loggedInUser.address }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item v-if="loggedInUser.phone">
              <v-list-item-icon><v-icon>mdi-phone</v-icon></v-list-item-icon>
              <v-list-item-content>
                <v-list-item-subtitle>เบอร์โทร</v-list-item-subtitle>
                <v-list-item-title>{{ loggedInUser.phone }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item v-if="loggedInUser.description">
              <v-list-item-icon><v-icon>mdi-note-text</v-icon></v-list-item-icon>
              <v-list-item-content>
                <v-list-item-subtitle>คำอธิบาย</v-list-item-subtitle>
                <v-list-item-title>{{ loggedInUser.description }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
            <v-list-item v-if="loggedInUser.created_at">
              <v-list-item-icon><v-icon>mdi-calendar</v-icon></v-list-item-icon>
              <v-list-item-content>
                <v-list-item-subtitle>บัญชีสร้างเมื่อ</v-list-item-subtitle>
                <v-list-item-title>{{ loggedInUser.created_at }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
          <v-card-actions>
            <v-btn color="primary" outlined @click="openEditDialog">
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

        <!-- Edit Profile Dialog -->
        <v-dialog v-model="editDialog" max-width="600px">
          <v-card>
            <v-card-title>
              <span class="headline">แก้ไขโปรไฟล์</span>
            </v-card-title>
            <v-card-text>
              <v-form ref="editForm">
                <v-container>
                  <v-row v-for="(value, key) in editableFields" :key="key">
                    <v-col cols="4">
                      <strong>{{ fieldLabels[key] || key }}</strong>
                    </v-col>
                    <v-col cols="8">
                      <v-text-field v-model="editedUser[key]" :label="fieldLabels[key] || key" :disabled="key === idField" dense></v-text-field>
                    </v-col>
                  </v-row>
                </v-container>
              </v-form>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="closeEditDialog">ยกเลิก</v-btn>
              <v-btn color="green darken-1" text @click="saveEdit">บันทึก</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'ProfilePage',
  data() {
    return {
      loggedInUser: null,
      isAdmin: false,
      editDialog: false,
      editedUser: {},
      idField: 'id',
      editableFields: {},
      fieldLabels: {
        fullname: 'ชื่อ-นามสกุล',
        display_name: 'ชื่อที่แสดง',
        email: 'อีเมล',
        phone: 'เบอร์โทร',
        address: 'ที่อยู่',
        position: 'ตำแหน่ง'
      }
    }
  },
  async mounted() {
    let authUser = null;
    try {
      authUser = JSON.parse(localStorage.getItem('auth_user'));
    } catch (e) {}
    if (authUser && authUser.email) {
      try {
        const res = await fetch('http://localhost/dewgasohol_beta/deeplink_select.php');
        const users = await res.json();
        const found = users.find(u => u.email === authUser.email);
        if (found) {
          this.loggedInUser = found;
          this.isAdmin = found.position === 'super admin';
          // เตรียมฟิลด์ที่แก้ไขได้ (ยกเว้น id, email, position)
          this.editableFields = {};
          Object.keys(found).forEach(key => {
            if (![this.idField, 'email', 'position'].includes(key)) {
              this.editableFields[key] = found[key];
            }
          });
        }
      } catch (e) {
        this.loggedInUser = null;
        this.isAdmin = false;
      }
    }
  },
  methods: {
    logout() {
      localStorage.removeItem('auth_user');
      this.$router.push('/deep_link/user_signin');
    },
    openEditDialog() {
      // เตรียมข้อมูล user ที่จะแก้ไข (รวม id)
      this.editedUser = { ...this.loggedInUser };
      this.editDialog = true;
    },
    closeEditDialog() {
      this.editDialog = false;
      this.editedUser = {};
    },
    async saveEdit() {
      try {
        const res = await fetch('http://localhost/dewgasohol_beta/deeplink_update.php', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.editedUser)
        });
        const result = await res.json();
        if (result.success) {
          this.$toast && this.$toast.success('บันทึกสำเร็จ');
          // อัปเดตข้อมูลใหม่
          this.loggedInUser = { ...this.editedUser };
          this.closeEditDialog();
        } else {
          this.$toast && this.$toast.error('บันทึกไม่สำเร็จ: ' + (result.message || ''));
        }
      } catch (e) {
        this.$toast && this.$toast.error('เกิดข้อผิดพลาด');
      }
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
