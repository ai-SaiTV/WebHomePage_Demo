<script setup lang="ts">
import { Line } from 'vue-chartjs';
import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend } from 'chart.js';
import type { Student } from '../../../types';

ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend);

defineProps<{
  student: Student;
}>();

const progressData = {
  labels: ['第一周', '第二周', '第三周', '第四周', '第五周'],
  datasets: [
    {
      label: '学习进度',
      data: [70, 75, 82, 85, 88],
      borderColor: '#3451b2',
      tension: 0.4
    }
  ]
};

const options = {
  responsive: true,
  maintainAspectRatio: false,
};
</script>

<template>
  <div class="space-y-4">
    <h4 class="text-lg font-semibold">学习进度</h4>
    <div class="h-[200px]">
      <Line :data="progressData" :options="options" />
    </div>
  </div>
</template>