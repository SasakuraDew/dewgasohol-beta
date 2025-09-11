<template>
  <div class="oil-prices-page">
    <v-container>
      <!-- Header Section -->
      <v-row align="center" justify="center" class="text-center my-8">
        <v-col cols="12">
          <h1 class="display-2 font-weight-bold">
            ราคาน้ำมันวันนี้
          </h1>
          <p class="headline mt-4">
            อัปเดตล่าสุด: {{ lastUpdated }}
          </p>
        </v-col>
      </v-row>

      <!-- Oil Price Cards -->
      <v-row justify="center">
        <v-col
          v-for="oil in oilPrices"
          :key="oil.name"
          cols="12"
          sm="6"
          md="4"
          lg="3"
        >
          <v-card class="oil-card" :style="{ 'border-left': `5px solid ${oil.color}` }">
            <v-card-title class="d-flex justify-space-between">
              <span class="font-weight-bold">{{ oil.name }}</span>
              <v-icon :color="oil.color" large>mdi-fuel</v-icon>
            </v-card-title>
            <v-card-text class="text-center">
              <div class="price-display">
                {{ oil.price.toFixed(2) }}
              </div>
              <div class="price-unit">บาท/ลิตร</div>
              <div class="price-change" :class="getChangeColor(oil.change)">
                <v-icon small :class="getChangeColor(oil.change)">
                  {{ getChangeIcon(oil.change) }}
                </v-icon>
                {{ oil.change.toFixed(2) }}
              </div>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>

       <!-- Action Buttons -->
      <v-row justify="center" class="mt-8">
        <v-col cols="12" md="6" class="text-center">
          <v-btn color="primary" class="mx-2">
            <v-icon left>mdi-history</v-icon>
            ดูประวัติราคา
          </v-btn>
          <v-btn color="secondary" class="mx-2">
            <v-icon left>mdi-map-marker</v-icon>
            เส้นทางไปปั๊มใกล้ฉัน
          </v-btn>
        </v-col>
      </v-row>

    </v-container>
  </div>
</template>

<script>
export default {
  name: 'OilPricesPage',
  data() {
    return {
      lastUpdated: '11 กันยายน 2568 เวลา 15:00 น.',
      oilPrices: [
        { name: 'แก๊สโซฮอล์ 95', price: 38.50, change: -0.20, color: '#FF7F00' }, // Orange
        { name: 'แก๊สโซฮอล์ 91', price: 37.90, change: 0.10, color: '#4CAF50' },  // Green
        { name: 'ดีเซล B7', price: 30.40, change: 0.00, color: '#2196F3' },    // Blue
        { name: 'E20', price: 36.44, change: -0.20, color: '#9C27B0' },       // Purple
        { name: 'E85', price: 35.99, change: 0.10, color: '#673AB7' },       // Deep Purple
        { name: 'ดีเซลพรีเมียม', price: 43.94, change: 0.00, color: '#000000' }, // Black/Grey
      ],
    }
  },
  methods: {
    getChangeIcon(change) {
      if (change > 0) return 'mdi-arrow-up-bold'
      if (change < 0) return 'mdi-arrow-down-bold'
      return 'mdi-minus'
    },
    getChangeColor(change) {
      if (change > 0) return 'red--text'
      if (change < 0) return 'green--text'
      return 'grey--text'
    },
  },
}
</script>

<style scoped>
.oil-prices-page {
  padding: 20px 0;
  background-color: #f5f5f5;
  min-height: 100vh;
}

.display-2 {
  color: #333;
}

.headline {
  color: #555;
}

.oil-card {
  transition: all 0.3s ease-in-out;
  border-radius: 8px !important;
}

.oil-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 20px rgba(0,0,0,0.1) !important;
}

.price-display {
  font-size: 2.5rem;
  font-weight: bold;
  line-height: 1.2;
}

.price-unit {
  font-size: 1rem;
  color: #666;
  margin-bottom: 10px;
}

.price-change {
  font-size: 1.2rem;
  font-weight: bold;
}

.red--text {
  color: #E53935 !important;
}

.green--text {
  color: #43A047 !important;
}

.grey--text {
  color: #757575 !important;
}
</style>