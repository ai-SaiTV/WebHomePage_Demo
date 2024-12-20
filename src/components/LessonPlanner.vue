<script setup lang="ts">
import { ref } from 'vue';
import type { LessonPlan } from '../types';

const lessonPlan = ref<LessonPlan>({
  id: '',
  title: '',
  subject: '',
  grade: '',
  duration: 45,
  objectives: [],
  activities: [],
  resources: []
});

const generateLessonPlan = async () => {
  // TODO: Integrate with AI service to generate lesson plan
  console.log('Generating lesson plan...');
};
</script>

<template>
  <div class="p-6">
    <h2 class="text-2xl font-bold mb-4">课程设计助手</h2>
    <div class="space-y-4">
      <div>
        <label class="block text-sm font-medium text-gray-700">课程标题</label>
        <input
          v-model="lessonPlan.title"
          type="text"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <div>
        <label class="block text-sm font-medium text-gray-700">学科</label>
        <input
          v-model="lessonPlan.subject"
          type="text"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <div>
        <label class="block text-sm font-medium text-gray-700">年级</label>
        <input
          v-model="lessonPlan.grade"
          type="text"
          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>
      <button
        @click="generateLessonPlan"
        class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600"
      >
        生成教案
      </button>
    </div>
  </div>
</template>