<script setup lang="ts">
import { ref } from 'vue';
import type { LessonPlan } from '../../types';

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

const emit = defineEmits(['generate']);

const handleGenerate = () => {
  emit('generate', lessonPlan.value);
};
</script>

<template>
  <div class="space-y-4">
    <div class="space-y-2">
      <label class="block text-sm font-medium text-gray-700">课程标题</label>
      <input
        v-model="lessonPlan.title"
        type="text"
        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
        placeholder="输入课程标题"
      />
    </div>
    <div class="grid grid-cols-2 gap-4">
      <div class="space-y-2">
        <label class="block text-sm font-medium text-gray-700">学科</label>
        <input
          v-model="lessonPlan.subject"
          type="text"
          class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
          placeholder="选择学科"
        />
      </div>
      <div class="space-y-2">
        <label class="block text-sm font-medium text-gray-700">年级</label>
        <input
          v-model="lessonPlan.grade"
          type="text"
          class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
          placeholder="选择年级"
        />
      </div>
    </div>
    <button
      @click="handleGenerate"
      class="w-full px-4 py-2 bg-[#3451b2] text-white rounded-lg hover:bg-[#2d469d] transition-colors"
    >
      生成教案
    </button>
  </div>
</template>