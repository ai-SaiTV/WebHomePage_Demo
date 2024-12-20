<script setup lang="ts">
import { ref } from 'vue';
import ErrorAnalytics from './exercises/ErrorAnalytics.vue';
import ExerciseForm from './exercises/ExerciseForm.vue';
import QuestionBank from './exercises/QuestionBank.vue';
import type { Exercise, ErrorType } from '../types';

const activeTab = ref('generate'); // 'generate' | 'bank'
const exercises = ref<Exercise[]>([]);

// 模拟错题统计数据
const errorStats = ref<ErrorType[]>([
  { type: '概念理解', count: 45, percentage: 35 },
  { type: '计算错误', count: 38, percentage: 30 },
  { type: '应用题解析', count: 25, percentage: 20 },
  { type: '其他', count: 19, percentage: 15 }
]);

const generateExercises = async (params: any) => {
  // 模拟生成练习题
  console.log('Generating exercises with params:', params);
};
</script>

<template>
  <div class="p-6">
    <div class="max-w-6xl mx-auto">
      <!-- Error Analytics Section -->
      <div class="mb-8">
        <h2 class="text-2xl font-bold mb-4">错题分析</h2>
        <ErrorAnalytics :error-stats="errorStats" />
      </div>

      <!-- Tabs -->
      <div class="mb-6 border-b">
        <div class="flex space-x-4">
          <button
            v-for="tab in [
              { id: 'generate', label: '生成练习' },
              { id: 'bank', label: '题库' }
            ]"
            :key="tab.id"
            @click="activeTab = tab.id"
            :class="[
              'px-4 py-2 font-medium',
              activeTab === tab.id
                ? 'text-[#3451b2] border-b-2 border-[#3451b2]'
                : 'text-gray-500 hover:text-gray-700'
            ]"
          >
            {{ tab.label }}
          </button>
        </div>
      </div>

      <!-- Content -->
      <div v-if="activeTab === 'generate'">
        <ExerciseForm
          :error-stats="errorStats"
          @generate="generateExercises"
        />
      </div>
      <div v-else>
        <QuestionBank />
      </div>
    </div>
  </div>
</template>