
<template>
  <v-container>
    <v-card v-if="loggedInUser" class="mx-auto" max-width="400">
      <v-card-title class="headline">
        User Profile
      </v-card-title>
      <v-card-text>
        <v-list>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>{{ loggedInUser.display_name }}</v-list-item-title>
              <v-list-item-subtitle>Display Name</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>{{ loggedInUser.fullname }}</v-list-item-title>
              <v-list-item-subtitle>Full name</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>{{ loggedInUser.email }}</v-list-item-title>
              <v-list-item-subtitle>Email</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-card-text>
    </v-card>
    <v-alert v-else type="info">
      No user is currently logged in.
    </v-alert>

    <v-card class="mt-8">
      <v-card-title>All Users</v-card-title>
      <v-card-text>
        <v-data-table
          :headers="headersWithActions"
          :items="users"
          :items-per-page="10"
          class="elevation-1"
          dense
        >
          <template v-slot:item.actions="{ item }">
            <v-btn color="primary" small @click="openEditDialog(item)">แก้ไข</v-btn>
            <v-btn color="error" small @click="openDeleteDialog(item)">ลบ</v-btn>
          </template>
        <!-- Delete User Dialog -->
        <v-dialog v-model="deleteDialog" max-width="400px">
          <v-card>
            <v-card-title class="headline">ยืนยันการลบผู้ใช้</v-card-title>
            <v-card-text>
              ต้องการลบผู้ใช้ <strong>{{ userToDelete && userToDelete.display_name }}</strong> หรือไม่?
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="closeDeleteDialog">ยกเลิก</v-btn>
              <v-btn color="red darken-1" text @click="confirmDelete">ลบ</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
        <!-- Snackbar for status -->
        <v-snackbar v-model="snackbar.show" :color="snackbar.color" :timeout="2000">
          {{ snackbar.text }}
        </v-snackbar>
          <template v-slot:no-data>
            No user data found.
          </template>
        </v-data-table>

        <!-- Edit User Dialog -->
        <v-dialog v-model="editDialog" max-width="600px">
          <v-card>
            <v-card-title>
              <span class="headline">แก้ไขข้อมูลผู้ใช้</span>
            </v-card-title>
            <v-card-text>
              <v-form ref="editForm">
                <v-container>
                  <v-row v-for="(value, key) in editedUser" :key="key">
                    <v-col cols="4">
                      <strong>{{ key }}</strong>
                    </v-col>
                    <v-col cols="8">
                      <v-text-field v-model="editedUser[key]" :label="key" :disabled="key === idField" dense></v-text-field>
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
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  middleware: 'admin-auth',
  data() {
    return {
      users: [],
      headers: [],
      editDialog: false,
      editedUser: {},
  idField: 'id', // เปลี่ยนเป็นชื่อ primary key ของ users table ถ้าไม่ใช่ id
  deleteDialog: false,
  userToDelete: null,
  snackbar: { show: false, text: '', color: 'success' },
    openDeleteDialog(user) {
      this.userToDelete = user;
      this.deleteDialog = true;
    },
    closeDeleteDialog() {
      this.deleteDialog = false;
      this.userToDelete = null;
    },
    async confirmDelete() {
      if (!this.userToDelete) return;
      try {
        const res = await fetch('http://localhost/dewgasohol_beta/deeplink_delete.php', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ id: this.userToDelete[this.idField] })
        });
        const result = await res.json();
        if (result.success) {
          this.snackbar = { show: true, text: 'ลบสำเร็จ', color: 'success' };
          await this.fetchUsers();
        } else {
          this.snackbar = { show: true, text: 'ลบไม่สำเร็จ', color: 'error' };
        }
      } catch (e) {
        this.snackbar = { show: true, text: 'เกิดข้อผิดพลาด', color: 'error' };
      }
      this.closeDeleteDialog();
    },
    }
  },
  computed: {
    ...mapGetters({
      loggedInUser: 'auth/loggedInUser'
    }),
    headersWithActions() {
      if (this.headers.length === 0) return [];
      return [
        ...this.headers,
        { text: 'Actions', value: 'actions', sortable: false }
      ];
    }
  },
  async mounted() {
    await this.fetchUsers();
  },
  methods: {
    async fetchUsers() {
      try {
        const res = await fetch('http://localhost/dewgasohol_beta/deeplink_select.php');
        const users = await res.json();
        this.users = users;
        if (users.length > 0) {
          this.headers = Object.keys(users[0]).map(key => ({ text: key, value: key }));
        }
      } catch (e) {
        this.users = [];
        this.headers = [];
      }
    },
    openEditDialog(user) {
      this.editedUser = { ...user };
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
          this.snackbar = { show: true, text: 'บันทึกสำเร็จ', color: 'success' };
          await this.fetchUsers();
          this.closeEditDialog();
        } else {
          this.snackbar = { show: true, text: 'บันทึกไม่สำเร็จ', color: 'error' };
        }
      } catch (e) {
        this.snackbar = { show: true, text: 'เกิดข้อผิดพลาด', color: 'error' };
      }
    }
  }
}
</script>