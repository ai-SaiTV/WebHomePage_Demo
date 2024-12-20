<script setup lang="ts">
import { Doughnut } from 'vue-chartjs';
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';
import type { Student } from '../../../types';

ChartJS.register(ArcElement, Tooltip, Legend);

defineProps<{
  student: Student;
}>();

const mistakesData = {
  labels: ['计算错误', '概念理解错误', '应用错误'],
  datasets: [
    {
      data: [12, 8, 5],
      backgroundColor: ['#3451b2', '#34c759', '#ff9500'],
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
    <h4 class="text-lg font-semibold">错题分析</h4>
    <div class="grid grid-cols-2 gap-4">
      <div class="h-[200px]">
        <Doughnut :data="mistakesData" :options="options" />
      </div>
      <div class="space-y-2">
        <div
          v-for="(dataset, index) in mistakesData.datasets[0].data"
          :key="index"
          class="flex justify-between items-center p-2 bg-gray-50 rounded"
        >
          <span>{{ mistakesData.labels[index] }}</span>
          <span class="font-medium">{{ dataset }}次</span>
        </div>
      </div>
    </div>
  </div>
</template>