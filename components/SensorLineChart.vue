
<template>
  <div style="height: 400px;">
    <canvas></canvas>
  </div>
</template>

<script>
import { Line } from 'vue-chartjs'

export default {
  name: 'SensorLineChart',
  extends: Line,
  props: {
    sensorData: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          xAxes: [
            {
              type: 'category',
              scaleLabel: {
                display: true,
                labelString: 'Time'
              }
            }
          ],
          yAxes: [
            {
              scaleLabel: {
                display: true,
                labelString: 'Value'
              }
            }
          ]
        }
      }
    }
  },
  watch: {
    sensorData: {
      handler() {
        this.renderChartData();
      },
      immediate: true
    }
  },
  mounted() {
    this.renderChartData();
  },
  methods: {
    renderChartData() {
      if (!this.sensorData || !this.sensorData.length) return;
      const labels = this.sensorData.map(item => {
        // แสดงเวลาแบบสั้น
        const d = new Date(item.created_at);
        return d.toLocaleString();
      });
      const temperature = this.sensorData.map(item => Number(item.temperature));
      const humidity = this.sensorData.map(item => Number(item.humidity));
      const datacollection = {
        labels,
        datasets: [
          {
            label: 'Temperature (°C)',
            borderColor: '#f87979',
            backgroundColor: 'rgba(248,121,121,0.1)',
            data: temperature,
            fill: false
          },
          {
            label: 'Humidity (%)',
            borderColor: '#36a2eb',
            backgroundColor: 'rgba(54,162,235,0.1)',
            data: humidity,
            fill: false
          }
        ]
      };
      this.renderChart(datacollection, this.options);
    }
  }
}
</script>

<style scoped>
div {
  height: 400px;
}
</style>
