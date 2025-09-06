<template>
  <v-container>
    <v-card>
      <v-card-title>
        รายชื่อสถานีบริการน้ำมัน
        <v-spacer></v-spacer>
        <v-btn color="primary" @click="dialog = true">เพิ่มสถานี</v-btn>
      </v-card-title>
      <v-data-table
        :headers="headers"
        :items="stations"
        :loading="loading"
        class="elevation-1"
        loading-text="กำลังโหลดข้อมูล..."
      >
        <template v-slot:item.price="{ item }">
          {{ item.price ? item.price : '-' }}
        </template>
        <template v-slot:item.updated_at="{ item }">
          {{ item.updated_at ? item.updated_at : '-' }}
        </template>
        <template v-slot:item.action="{ item }">
          <v-btn icon color="red" @click="deleteStation(item.id)">
            <v-icon>mdi-delete</v-icon>
          </v-btn>
        </template>
        <template v-slot:item.edit="{ item }">
          <v-btn icon color="blue" @click="openEditDialog(item)">
            <v-icon>mdi-pencil</v-icon>
          </v-btn>
        </template>
      </v-data-table>
    </v-card>
  <!-- Dialog สำหรับเพิ่มสถานี -->
    <!-- Dialog ยืนยันการลบ -->
    <v-dialog v-model="confirmDeleteDialog" max-width="400px">
      <v-card>
        <v-card-title class="headline">ยืนยันการลบข้อมูล</v-card-title>
        <v-card-text>คุณต้องการลบข้อมูลสถานีนี้ใช่หรือไม่?</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text @click="confirmDeleteDialog = false">ยกเลิก</v-btn>
          <v-btn color="red" @click="confirmDelete">ลบ</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog v-model="dialog" max-width="500px">
      <v-card>
        <v-card-title>เพิ่มสถานีบริการน้ำมัน</v-card-title>
        <v-card-text>
          <v-form ref="form" v-model="formValid">
            <v-text-field v-model="form.name" label="ชื่อสถานี" :rules="[v => !!v || 'กรุณากรอกชื่อสถานี']" required></v-text-field>
            <v-text-field v-model="form.location" label="ที่ตั้ง"></v-text-field>
            <v-text-field v-model="form.fuel_type" label="ประเภทน้ำมัน"></v-text-field>
            <v-text-field v-model="form.price" label="ราคา" type="number"></v-text-field>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text @click="dialog = false">ยกเลิก</v-btn>
          <v-btn color="primary" :disabled="!formValid" @click="addStation">บันทึก</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Dialog สำหรับแก้ไขสถานี -->
    <v-dialog v-model="editDialog" max-width="500px">
      <v-card>
        <v-card-title>แก้ไขข้อมูลสถานีบริการน้ำมัน</v-card-title>
        <v-card-text>
          <v-form ref="editForm" v-model="editFormValid">
            <v-text-field v-model="editForm.name" label="ชื่อสถานี" :rules="[v => !!v || 'กรุณากรอกชื่อสถานี']" required></v-text-field>
            <v-text-field v-model="editForm.location" label="ที่ตั้ง"></v-text-field>
            <v-text-field v-model="editForm.fuel_type" label="ประเภทน้ำมัน"></v-text-field>
            <v-text-field v-model="editForm.price" label="ราคา" type="number"></v-text-field>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text @click="editDialog = false">ยกเลิก</v-btn>
          <v-btn color="primary" :disabled="!editFormValid" @click="updateStation">บันทึก</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-snackbar v-model="snackbar.show" :color="snackbar.color" top right>
      {{ snackbar.text }}
    </v-snackbar>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
  stations: [],
  confirmDeleteDialog: false,
  stationIdToDelete: null,
      loading: false,
      dialog: false,
      formValid: false,
      form: {
        name: '',
        location: '',
        fuel_type: '',
        price: ''
      },
      editDialog: false,
      editFormValid: false,
      editForm: {
        id: '',
        name: '',
        location: '',
        fuel_type: '',
        price: ''
      },
      snackbar: {
        show: false,
        text: '',
        color: 'success'
      },
      headers: [
        { text: 'ID', value: 'id' },
        { text: 'ชื่อสถานี', value: 'name' },
        { text: 'ที่ตั้ง', value: 'location' },
        { text: 'ประเภทน้ำมัน', value: 'fuel_type' },
        { text: 'ราคา', value: 'price' },
        { text: 'อัปเดตล่าสุด', value: 'updated_at' },
        { text: 'ลบ', value: 'action', sortable: false },
        { text: 'แก้ไข', value: 'edit', sortable: false }
      ]
    }
  },
  async mounted() {
    this.fetchStations();
  },
  methods: {
    async fetchStations() {
      this.loading = true;
      try {
        const res = await this.$axios.get('http://localhost/dewgasohol_beta/stations_select.php');
        this.stations = res.data;
      } catch (e) {
        this.stations = [];
      }
      this.loading = false;
    },
    async addStation() {
      if (!this.$refs.form.validate()) return;
      try {
        const res = await this.$axios.post('http://localhost/dewgasohol_beta/stations_insert.php', this.form);
        if (res.data.success) {
          this.snackbar = { show: true, text: 'เพิ่มสถานีสำเร็จ!', color: 'success' };
        } else {
          this.snackbar = { show: true, text: 'เกิดข้อผิดพลาด: ' + (res.data.error || 'ไม่สามารถเพิ่มข้อมูลได้'), color: 'error' };
        }
        this.dialog = false;
        this.form = { name: '', location: '', fuel_type: '', price: '' };
        this.fetchStations();
      } catch (e) {
        this.snackbar = { show: true, text: 'เกิดข้อผิดพลาดในการเชื่อมต่อ', color: 'error' };
      }
    },
    openEditDialog(item) {
      this.editForm = { ...item };
      this.editDialog = true;
    },
    async updateStation() {
      if (!this.$refs.editForm.validate()) return;
      try {
        await this.$axios.post('http://localhost/dewgasohol_beta/stations_update.php', {
          id: this.editForm.id,
          name: this.editForm.name,
          location: this.editForm.location,
          fuel_type: this.editForm.fuel_type,
          price: this.editForm.price
        });
        this.snackbar = { show: true, text: 'แก้ไขข้อมูลสำเร็จ!', color: 'success' };
        this.editDialog = false;
        this.fetchStations();
      } catch (e) {
        this.snackbar = { show: true, text: 'เกิดข้อผิดพลาดในการเชื่อมต่อ', color: 'error' };
      }
    },
    deleteStation(id) {
      this.stationIdToDelete = id;
      this.confirmDeleteDialog = true;
    },
    async confirmDelete() {
      try {
        const res = await this.$axios.post('http://localhost/dewgasohol_beta/stations_delete.php', { id: this.stationIdToDelete });
        if (res.data.success) {
          this.snackbar = { show: true, text: 'ลบข้อมูลสำเร็จ!', color: 'success' };
          this.fetchStations();
        } else {
          this.snackbar = { show: true, text: 'เกิดข้อผิดพลาด: ' + (res.data.error || 'ไม่สามารถลบข้อมูลได้'), color: 'error' };
        }
      } catch (e) {
        this.snackbar = { show: true, text: 'เกิดข้อผิดพลาดในการเชื่อมต่อ', color: 'error' };
      }
      this.confirmDeleteDialog = false;
      this.stationIdToDelete = null;
    }
  }
}
</script>

<style scoped>
.v-card {
  margin-top: 30px;
}
</style>
