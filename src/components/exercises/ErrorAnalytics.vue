<script setup lang="ts">
import { Pie } from 'vue-chartjs';
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';
import type { ErrorType } from '../../types';

ChartJS.register(ArcElement, Tooltip, Legend);

const props = defineProps<{
  errorStats: ErrorType[];
}>();

const chartData = {
  labels: props.errorStats.map(stat => stat.type),
  datasets: [{
    data: props.errorStats.map(stat => stat.percentage),
    backgroundColor: ['#3451b2', '#34c759', '#ff9500', '#ff3b30'],
  }]
};

const options = {
  responsive: true,
  maintainAspectRatio: false,
};
</script>

<template>
  <div class="grid grid-cols-2 gap-6 bg-white rounded-lg shadow-sm p-6">
    <div class="h-[300px]">
      <Pie :data="chartData" :options="options" />
    </div>
    <div class="space-y-4">
      <h3 class="text-lg font-medium mb-4">错题类型分布</h3>
      <div
        v-for="stat in errorStats"
        :key="stat.type"
        class="flex items-center justify-between p-3 bg-gray-50 rounded-lg"
      >
        <span class="font-medium">{{ stat.type }}</span>
        <div class="text-right">
          <div class="font-semibold">{{ stat.count }}次</div>
          <div class="text-sm text-gray-500">{{ stat.percentage }}%</div>
        </div>
      </div>
    </div>
  </div>
</template>