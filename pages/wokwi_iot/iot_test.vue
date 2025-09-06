<template>
		<v-container>
			<v-card class="mb-4">
				<v-card-title>เพิ่มข้อมูล Sensor</v-card-title>
				<v-card-text>
					<v-form ref="form" v-model="formValid" lazy-validation>
						<v-row>
							<v-col cols="12" sm="6">
								<v-text-field v-model="form.temperature" label="Temperature (°C)" type="number" :rules="[v => !!v || 'กรุณากรอกอุณหภูมิ']" required></v-text-field>
							</v-col>
							<v-col cols="12" sm="6">
								<v-text-field v-model="form.humidity" label="Humidity (%)" type="number" :rules="[v => !!v || 'กรุณากรอกความชื้น']" required></v-text-field>
							</v-col>
						</v-row>
						<v-btn color="primary" :disabled="!formValid || inserting" @click="insertSensorData">เพิ่มข้อมูล</v-btn>
					</v-form>
				</v-card-text>
			</v-card>
			<v-card>
				<v-card-title>Sensor Data Table</v-card-title>
				<v-data-table
					:headers="headers"
					:items="sensorData"
					:loading="loading"
					class="elevation-1"
				>
					<template v-slot:item.created_at="{ item }">
						{{ new Date(item.created_at).toLocaleString() }}
					</template>
				</v-data-table>
			</v-card>
		</v-container>
</template>

<script>
export default {
		data() {
			return {
				sensorData: [],
				loading: false,
				inserting: false,
				formValid: false,
				form: {
					temperature: '',
					humidity: ''
				},
				headers: [
					{ text: 'ID', value: 'id' },
					{ text: 'Temperature (°C)', value: 'temperature' },
					{ text: 'Humidity (%)', value: 'humidity' },
					{ text: 'Created At', value: 'created_at' }
				]
			}
		},
		mounted() {
			this.fetchSensorData();
		},
		methods: {
			async fetchSensorData() {
				this.loading = true;
				try {
					const res = await this.$axios.get('http://localhost/dewgasohol_beta/sensor_select.php');
					this.sensorData = res.data;
				} catch (e) {
					this.sensorData = [];
				}
				this.loading = false;
			},
			async insertSensorData() {
				if (!this.$refs.form.validate()) return;
				this.inserting = true;
				try {
					const payload = {
						temperature: this.form.temperature,
						humidity: this.form.humidity
					};
					const res = await this.$axios.post('http://localhost/dewgasohol_beta/sensor_insert.php', payload);
					if (res.data && res.data.success) {
						this.$refs.form.reset();
						this.form.temperature = '';
						this.form.humidity = '';
						this.fetchSensorData();
					} else {
						alert('เพิ่มข้อมูลไม่สำเร็จ');
					}
				} catch (e) {
					alert('เกิดข้อผิดพลาดในการเชื่อมต่อ');
				}
				this.inserting = false;
			}
		}
}
</script>

<style scoped>

</style>
