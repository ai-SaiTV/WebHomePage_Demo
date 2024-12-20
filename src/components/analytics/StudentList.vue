<script setup lang="ts">
import { ref } from 'vue';
import type { Student } from '../../types';

// Fake student data
const students = ref<Student[]>([
  { id: '1', name: '张三', grade: '85', attendance: '95%' },
  { id: '2', name: '李四', grade: '92', attendance: '98%' },
  { id: '3', name: '王五', grade: '78', attendance: '88%' },
  // Add more fake data as needed
]);

defineProps<{
  selectedId?: string;
}>();

const emit = defineEmits(['select']);
</script>

<template>
  <div class="space-y-2">
    <button
      v-for="student in students"
      :key="student.id"
      @click="emit('select', student)"
      :class="[
        'w-full p-3 rounded-lg text-left transition-colors',
        selectedId === student.id
          ? 'bg-[#e6ebf9] text-[#3451b2]'
          : 'hover:bg-gray-50'
      ]"
    >
      <div class="font-medium">{{ student.name }}</div>
      <div class="text-sm text-gray-500">
        平均成绩: {{ student.grade }} | 出勤率: {{ student.attendance }}
      </div>
    </button>
  </div>
</template>