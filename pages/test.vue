<template>
  <v-container>
    <v-card>
      <v-card-title>Preview ข้อมูลจาก test_select.php</v-card-title>
      <v-card-text>
        <div v-if="loading">Loading...</div>
        <div v-else v-html="previewHtml"></div>
          <div v-else>
            <div v-for="table in parsedTables" :key="table.name">
              <h3>{{ table.name }}</h3>
              <div style="margin-bottom: 8px;">
                <v-btn color="error" small @click="deleteTable(table)">ลบข้อมูลทั้งหมดในตารางนี้</v-btn>
              </div>
              <v-simple-table>
                <thead>
                  <tr>
                    <th v-for="col in table.columns" :key="col">{{ col }}</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="row in table.rows" :key="row[table.idField]">
                    <td v-for="col in table.columns" :key="col">{{ row[col] }}</td>
                  </tr>
                </tbody>
              </v-simple-table>
            </div>
          </div>
        <v-divider class="my-4"></v-divider>
        <v-form ref="form" v-model="formValid" lazy-validation>
          <v-text-field v-model="form.category_name" label="ชื่อหมวดหมู่" required></v-text-field>
          <v-btn color="primary" :disabled="!formValid || submitting" @click="addCategory">เพิ่มข้อมูล</v-btn>
        </v-form>
        <div v-if="submitMsg" class="mt-2">{{ submitMsg }}</div>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
  previewHtml: '',
  parsedTables: [],
      loading: true,
      form: {
        category_name: ''
      },
      formValid: false,
      submitting: false,
      submitMsg: ''
    }
  },
  async mounted() {
    await this.loadPreview();
  },
  methods: {
    async loadPreview() {
      this.loading = true;
      try {
        const res = await fetch('http://localhost/test/test_select.php');
        const html = await res.text();
        this.previewHtml = html;
          this.parsedTables = this.parseTables(html);
      } catch (e) {
        this.previewHtml = 'เกิดข้อผิดพลาดในการโหลดข้อมูล';
          this.parsedTables = [];
      }
      this.loading = false;
    },
      parseTables(html) {
        // แปลง HTML เป็น array ของ table
        const tables = [];
        const div = document.createElement('div');
        div.innerHTML = html;
        const tableEls = div.querySelectorAll('h3 + table');
        div.querySelectorAll('h3').forEach((h3, i) => {
          const name = h3.textContent;
          const tableEl = tableEls[i];
          if (!tableEl) return;
          const columns = Array.from(tableEl.querySelectorAll('th')).map(th => th.textContent);
          const rows = Array.from(tableEl.querySelectorAll('tr')).slice(1).map(tr => {
            const tds = Array.from(tr.querySelectorAll('td'));
            const row = {};
            columns.forEach((col, idx) => row[col] = tds[idx]?.textContent);
            return row;
          });
          // หาชื่อ id field
          const idField = columns.find(c => c === 'id' || c.endsWith('_id')) || columns[0];
          tables.push({ name, columns, rows, idField });
        });
        return tables;
      },
      async deleteRow(table, id, idField) {
        // ฟังก์ชันนี้ยังคงอยู่สำหรับการลบแถวเดี่ยว หากต้องการกลับไปใช้แบบเดิม
      },
      async deleteTable(table) {
        if (!confirm('ต้องการลบข้อมูลทั้งหมดในตารางนี้ใช่หรือไม่?')) return;
        const formData = new FormData();
        formData.append('table', table.name);
        formData.append('delete_all', '1');
        try {
          const res = await fetch('http://localhost/test/test_delete.php', {
            method: 'POST',
            body: formData
          });
          const text = await res.text();
          alert(text);
          await this.loadPreview();
        } catch (e) {
          alert('เกิดข้อผิดพลาดในการลบข้อมูล');
        }
      },
    async addCategory() {
      this.submitting = true;
      this.submitMsg = '';
      try {
        const formData = new FormData();
        formData.append('category_name', this.form.category_name);
        const res = await fetch('http://localhost/test/test_update.php', {
          method: 'POST',
          body: formData
        });
        const text = await res.text();
        this.submitMsg = text;
        this.form.category_name = '';
        await this.loadPreview();
      } catch (e) {
        this.submitMsg = 'เกิดข้อผิดพลาดในการเพิ่มข้อมูล';
      }
      this.submitting = false;
    }
  }
}
</script>

<style scoped>
table { margin-bottom: 32px; }
th, td { padding: 4px 8px; }
</style>
