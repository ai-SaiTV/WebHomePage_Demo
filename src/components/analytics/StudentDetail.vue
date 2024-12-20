<script setup lang="ts">
import { computed } from 'vue';
import type { Student } from '../../types';
import StudentHomework from './detail/StudentHomework.vue';
import StudentMistakes from './detail/StudentMistakes.vue';
import StudentProgress from './detail/StudentProgress.vue';

defineProps<{
  student: Student;
}>();

defineEmits(['close']);
</script>

<template>
  <div class="fixed inset-0 bg-black/20 flex items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg w-[800px] max-h-[80vh] overflow-hidden">
      <!-- Header -->
      <div class="p-4 border-b flex justify-between items-center">
        <h3 class="text-xl font-bold">{{ student.name }} - 学习分析</h3>
        <button
          @click="$emit('close')"
          class="text-gray-500 hover:text-gray-700"
        >
          ✕
        </button>
      </div>

      <!-- Content -->
      <div class="p-6 overflow-y-auto">
        <div class="space-y-6">
          <StudentProgress :student="student" />
          <StudentHomework :student="student" />
          <StudentMistakes :student="student" />
        </div>
      </div>
    </div>
  </div>
</template>