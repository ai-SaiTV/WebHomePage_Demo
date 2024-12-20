<script setup lang="ts">
import { Line } from 'vue-chartjs';
import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend } from 'chart.js';
import { ref, onMounted } from 'vue';

ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend);

const chartData = ref({
  labels: ['第一周', '第二周', '第三周', '第四周', '第五周'],
  datasets: [
    {
      label: '班级平均分',
      data: [75, 78, 82, 80, 85],
      borderColor: '#3451b2',
      tension: 0.4
    },
    {
      label: '最高分',
      data: [90, 92, 95, 88, 93],
      borderColor: '#34c759',
      tension: 0.4
    }
  ]
});

const options = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      position: 'top' as const
    }
  }
};
</script>

<template>
  <div class="h-[400px]">
    <Line :data="chartData" :options="options" />
  </div>
</template>