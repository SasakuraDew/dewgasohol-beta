<template>
  <v-container fluid>
    <v-row>
      <v-col cols="12">
        <h1 class="text-h4">ภาพรวมสต๊อกน้ำมัน</h1>
      </v-col>
    </v-row>

    <!-- Oil Stock Summary Cards -->
    <v-row>
      <v-col
        v-for="fuel in fuelStocks"
        :key="fuel.id"
        cols="12"
        sm="6"
        md="4"
        lg="2"
      >
        <v-card>
          <v-card-title class="d-flex justify-space-between">
            <span>{{ fuel.name }}</span>
            <v-chip small :color="getAlertColor(fuel.percentage, fuel.name)">
              {{ fuel.percentage.toFixed(1) }}%
            </v-chip>
          </v-card-title>
          <v-card-text class="text-center">
            <div class="tank-visualization my-3 position-relative">
              <div class="tank-body">
                <div
                  class="fuel-level"
                  :style="{ height: fuel.percentage + '%', backgroundColor: getAlertColor(fuel.percentage, fuel.name) }"
                ></div>
              </div>
              <div class="tank-id-label">ถังที่ {{ fuel.id }}</div>
            </div>
            <p class="text-h5 font-weight-bold">{{ fuel.currentLiters.toLocaleString() }} ลิตร</p>
            <v-progress-linear
              :value="fuel.percentage"
              :color="getAlertColor(fuel.percentage, fuel.name)"
              height="20"
              striped
              class="mt-2"
            >
              <strong class="white--text">{{ fuel.percentage.toFixed(1) }}%</strong>
            </v-progress-linear>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <!-- Stock Management & History -->
    <v-row>
      <v-col cols="12">
        <v-card>
          <v-card-title>
            ประวัติการเบิก-เติม
            <v-spacer></v-spacer>
            <v-btn color="primary" class="mr-2" @click="showTransactionModal('add')">
              <v-icon left>mdi-plus</v-icon> เติมน้ำมัน
            </v-btn>
            <v-btn color="warning" class="mr-2" @click="showTransactionModal('withdraw')">
              <v-icon left>mdi-minus</v-icon> เบิกน้ำมัน
            </v-btn>
             <v-btn color="info" @click="editMode = !editMode">
              <v-icon left>mdi-pencil</v-icon> แก้ไขข้อมูล
            </v-btn>
          </v-card-title>
          <v-card-text>
            <v-data-table
              :headers="editMode ? historyHeadersEdit : historyHeaders"
              :items="transactionHistory"
              :items-per-page="10"
              class="elevation-1"
            >
              <template v-slot:item.actions="{ item }">
                <v-btn icon small color="info" @click="openEditDialog(item)"><v-icon>mdi-pencil</v-icon></v-btn>
                <v-btn icon small color="error" @click="openDeleteDialog(item)"><v-icon>mdi-delete</v-icon></v-btn>
              </template>
            </v-data-table>
    <!-- Modal: Edit Transaction -->
    <v-dialog v-model="editDialog" max-width="500px">
      <v-card>
        <v-card-title>
          <span class="text-h6">แก้ไขข้อมูล</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="editForm" v-model="editFormValid">
            <v-select
              v-model="editForm.tank_id"
              :items="fuelStocks.map(f=>({text:f.name,value:f.id}))"
              label="เลือกถังน้ำมัน"
              :rules="[v=>!!v||'กรุณาเลือกถัง']"
              required
            ></v-select>
            <v-select
              v-model="editForm.action"
              :items="['เติม','เบิก']"
              label="ประเภท"
              :rules="[v=>!!v||'กรุณาเลือกประเภท']"
              required
            ></v-select>
            <v-text-field
              v-model="editForm.amount"
              label="จำนวนลิตร"
              type="number"
              :rules="[v=>!!v||'กรุณากรอกจำนวน',v=>v>0||'ต้องมากกว่า 0']"
              required
            ></v-text-field>
            <v-text-field
              v-model="editForm.remain"
              label="คงเหลือหลังทำรายการ (ลิตร)"
              type="number"
              :rules="[v=>!!v||'กรุณากรอกคงเหลือ']"
              required
            ></v-text-field>
            <v-text-field
              v-model="editForm.created_at"
              label="วันที่"
              type="date"
              :rules="[v=>!!v||'กรุณาเลือกวันที่']"
              required
            ></v-text-field>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text @click="closeEditDialog">ยกเลิก</v-btn>
          <v-btn color="primary" :disabled="!editFormValid" @click="submitEdit">บันทึก</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <!-- Modal: Add/Withdraw Transaction -->
    <v-dialog v-model="transactionDialog" max-width="500px">
      <v-card>
        <v-card-title>
          <span class="text-h6">{{ transactionType === 'add' ? 'เติมน้ำมัน' : 'เบิกน้ำมัน' }}</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="transactionForm" v-model="transactionFormValid">
            <v-select
              v-model="transactionForm.tank_id"
              :items="fuelStocks.map(f=>({text:f.name,value:f.id}))"
              label="เลือกถังน้ำมัน"
              :rules="[v=>!!v||'กรุณาเลือกถัง']"
              required
            ></v-select>
            <v-text-field
              v-model="transactionForm.amount"
              label="จำนวนลิตร"
              type="number"
              :rules="[v=>!!v||'กรุณากรอกจำนวน',v=>v>0||'ต้องมากกว่า 0']"
              required
            ></v-text-field>
            <v-text-field
              v-model="transactionForm.remain"
              label="คงเหลือหลังทำรายการ (ลิตร)"
              type="number"
              :rules="[v=>!!v||'กรุณากรอกคงเหลือ']"
              required
            ></v-text-field>
            <v-text-field
              v-model="transactionForm.created_at"
              label="วันที่"
              type="date"
              :rules="[v=>!!v||'กรุณาเลือกวันที่']"
              required
            ></v-text-field>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn text @click="closeTransactionDialog">ยกเลิก</v-btn>
          <v-btn color="primary" :disabled="!transactionFormValid" @click="submitTransaction">บันทึก</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- Reports and Export -->
    <v-row>
        <v-col cols="12">
            <v-card>
                <v-card-title>รายงาน</v-card-title>
                <v-card-text>
                    <v-row align="center">
                        <v-col cols="12" md="4">
                            <v-menu
                                ref="dateMenu"
                                v-model="dateMenu"
                                :close-on-content-click="false"
                                transition="scale-transition"
                                offset-y
                                min-width="auto"
                            >
                                <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                    v-model="dateRangeText"
                                    label="เลือกระยะเวลา"
                                    prepend-icon="mdi-calendar"
                                    readonly
                                    v-bind="attrs"
                                    v-on="on"
                                ></v-text-field>
                                </template>
                                <v-date-picker
                                v-model="dateRange"
                                range
                                ></v-date-picker>
                            </v-menu>
                        </v-col>
                        <v-col cols="12" md="8">
                            <v-btn color="success" class="mr-2">
                                <v-icon left>mdi-file-excel</v-icon> Export to Excel
                            </v-btn>
                            <v-btn color="error">
                                <v-icon left>mdi-file-pdf-box</v-icon> Export to PDF
                            </v-btn>
                        </v-col>
                    </v-row>
                </v-card-text>
            </v-card>
        </v-col>
    </v-row>

  </v-container>
</template>

<script>
export default {
  middleware: 'admin-auth',
  layout: 'console',
  data() {
    return {
      editMode: false,
      fuelStocks: [
        { id: 1, name: 'แก๊สโซฮอล์ 95', currentLiters: 12000, capacityLiters: 20000 },
        { id: 2, name: 'แก๊สโซฮอล์ 91', currentLiters: 12000, capacityLiters: 20000 },
        { id: 3, name: 'ดีเซล B7', currentLiters: 20021, capacityLiters: 30000 },
        { id: 4, name: 'ดีเซลพรีเมียม', currentLiters: 2500, capacityLiters: 15000 },
        { id: 5, name: 'E20', currentLiters: 1800, capacityLiters: 10000 },
        { id: 6, name: 'E85', currentLiters: 950, capacityLiters: 10000 },
      ].map(fuel => ({
        ...fuel,
        percentage: (fuel.currentLiters / fuel.capacityLiters) * 100,
      })),
      historyHeaders: [
        { text: 'วันที่', value: 'created_at' },
        { text: 'รายการ', value: 'action' },
        { text: 'ถัง', value: 'tank_id' },
        { text: 'ปริมาณ (ลิตร)', value: 'amount', align: 'end' },
        { text: 'คงเหลือ (ลิตร)', value: 'remain', align: 'end' },
      ],
      historyHeadersEdit: [
        { text: 'วันที่', value: 'created_at' },
        { text: 'รายการ', value: 'action' },
        { text: 'ถัง', value: 'tank_id' },
        { text: 'ปริมาณ (ลิตร)', value: 'amount', align: 'end' },
        { text: 'คงเหลือ (ลิตร)', value: 'remain', align: 'end' },
        { text: 'การกระทำ', value: 'actions', sortable: false },
      ],
      editDialog: false,
      editForm: {
        id: '',
        tank_id: '',
        action: '',
        amount: '',
        remain: '',
        created_at: '',
      },
      editFormValid: false,
      transactionHistory: [],
      dateMenu: false,
      dateRange: [],
      // Modal state
      transactionDialog: false,
      transactionType: 'add',
      transactionForm: {
        tank_id: '',
        amount: '',
        remain: '',
        created_at: new Date().toISOString().slice(0, 10),
      },
      transactionFormValid: false,
    };
  },
  computed: {
    dateRangeText () {
      return this.dateRange.join(' ~ ')
    },
  },
  mounted() {
    this.fetchTransactionHistory();
  },
  methods: {
    openEditDialog(item) {
      this.editForm = {
        id: item.id,
        tank_id: item.tank_id,
        action: item.action,
        amount: item.amount.replace(/,/g, ''),
        remain: item.remain.replace(/,/g, ''),
        created_at: item.created_at,
      };
      this.editDialog = true;
    },
    closeEditDialog() {
      this.editDialog = false;
    },
    async submitEdit() {
      if (!this.editFormValid) return;
      const payload = { ...this.editForm };
      try {
        const res = await fetch('http://localhost/dewgasohol_beta/tank_history_update.php', {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload)
        });
        const result = await res.json();
        if (result.success) {
          this.$toast && this.$toast.success('แก้ไขสำเร็จ');
          this.fetchTransactionHistory();
          this.closeEditDialog();
        } else {
          this.$toast && this.$toast.error('แก้ไขไม่สำเร็จ: ' + (result.message || ''));
        }
      } catch (e) {
        this.$toast && this.$toast.error('เกิดข้อผิดพลาด');
      }
    },
    openDeleteDialog(item) {
      // TODO: implement delete modal
    },
    async fetchTransactionHistory() {
      try {
        const res = await fetch('http://localhost/dewgasohol_beta/tank_history.php');
        const data = await res.json();
        this.transactionHistory = data.map(item => ({
          ...item,
          amount: item.amount ? Number(item.amount).toLocaleString() : '',
          remain: item.remain ? Number(item.remain).toLocaleString() : '',
        }));
      } catch (e) {
        // error
      }
    },
    getAlertColor(percentage, fuelName) {
      if (fuelName === 'แก๊สโซฮอล์ 95') return '#ff9800';
      if (fuelName === 'ดีเซล B7') {
        if (percentage < 10) return 'red';
        if (percentage < 30) return 'yellow';
        return 'green';
      }
      if (percentage < 10) return 'red';
      if (percentage < 30) return 'yellow';
      return 'green';
    },
    showTransactionModal(type) {
      this.transactionType = type;
      this.transactionDialog = true;
      this.transactionForm = {
        tank_id: '',
        amount: '',
        remain: '',
        created_at: new Date().toISOString().slice(0, 10),
      };
    },
    closeTransactionDialog() {
      this.transactionDialog = false;
    },
    async submitTransaction() {
      if (!this.transactionFormValid) return;
      const payload = {
        ...this.transactionForm,
        action: this.transactionType === 'add' ? 'เติม' : 'เบิก',
      };
      await this.addTankHistory(payload);
      this.closeTransactionDialog();
    },

    async addTankHistory(payload) {
      try {
        const res = await fetch('http://localhost/dewgasohol_beta/tank_history_update.php', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload)
        });
        const result = await res.json();
        if (result.success) {
          this.$toast && this.$toast.success('บันทึกสำเร็จ');
          this.fetchTransactionHistory();
        } else {
          this.$toast && this.$toast.error('บันทึกไม่สำเร็จ: ' + (result.message || ''));
        }
      } catch (e) {
        this.$toast && this.$toast.error('เกิดข้อผิดพลาด');
      }
    },

    async editTankHistory(row) {
      // ตัวอย่าง: แก้ไขปริมาณ
      const newAmount = prompt('แก้ไขปริมาณ (ลิตร):', row.amount);
      if (!newAmount) return;
      try {
        const res = await fetch('http://localhost/dewgasohol_beta/tank_history_update.php', {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ id: row.id, amount: newAmount })
        });
        const result = await res.json();
        if (result.success) {
          this.$toast && this.$toast.success('แก้ไขสำเร็จ');
          this.fetchTransactionHistory();
        } else {
          this.$toast && this.$toast.error('แก้ไขไม่สำเร็จ: ' + (result.message || ''));
        }
      } catch (e) {
        this.$toast && this.$toast.error('เกิดข้อผิดพลาด');
      }
    },
  },
};
</script>

<style scoped>
.tank-visualization {
  display: inline-block;
  width: 80px;
  height: 120px;
  border: 3px solid #333333;
  border-radius: 10px;
  position: relative;
  background-color: #ffffff;
  overflow: hidden;
}

.tank-id-label {
  position: absolute;
  top: 6px;
  left: 0;
  width: 100%;
  text-align: center;
  font-size: 1rem;
  font-weight: bold;
  color: #333;
  z-index: 2;
  pointer-events: none;
}

.tank-body {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column-reverse;
}

.fuel-level {
  width: 100%;
  transition: height 0.5s ease-in-out, background-color 0.5s ease-in-out;
}

.v-card-title {
    font-size: 1rem;
}
</style>
