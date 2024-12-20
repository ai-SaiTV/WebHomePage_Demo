<script setup lang="ts">
import type { Student } from '../../../types';

defineProps<{
  student: Student;
}>();

// Fake homework data
const homeworkList = [
  { id: 1, title: '第一章练习', score: 90, submitDate: '2024-02-01' },
  { id: 2, title: '第二章练习', score: 85, submitDate: '2024-02-08' },
  { id: 3, title: '第三章练习', score: 95, submitDate: '2024-02-15' },
];
</script>

<template>
  <div class="space-y-4">
    <h4 class="text-lg font-semibold">作业完成情况</h4>
    <div class="space-y-2">
      <div
        v-for="homework in homeworkList"
        :key="homework.id"
        class="p-3 bg-gray-50 rounded-lg flex justify-between items-center"
      >
        <div>
          <div class="font-medium">{{ homework.title }}</div>
          <div class="text-sm text-gray-500">提交日期: {{ homework.submitDate }}</div>
        </div>
        <div class="text-lg font-semibold" :class="homework.score >= 90 ? 'text-green-600' : 'text-blue-600'">
          {{ homework.score }}分
        </div>
      </div>
    </div>
  </div>
</template>