<script setup lang="ts">
import { ref } from 'vue';

const questions = ref([
  {
    id: 1,
    title: '二次函数应用题',
    type: '应用题解析',
    difficulty: 'medium',
    usageCount: 156
  },
  {
    id: 2,
    title: '数列求和公式',
    type: '概念理解',
    difficulty: 'hard',
    usageCount: 89
  },
  {
    id: 3,
    title: '三角函数基础',
    type: '计算错误',
    difficulty: 'easy',
    usageCount: 234
  }
]);

const searchQuery = ref('');
const selectedType = ref('all');
</script>

<template>
  <div class="bg-white rounded-lg shadow-sm p-6">
    <div class="flex space-x-4 mb-6">
      <input
        v-model="searchQuery"
        type="text"
        placeholder="搜索题目..."
        class="flex-1 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
      />
      <select
        v-model="selectedType"
        class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
      >
        <option value="all">全部类型</option>
        <option value="concept">概念理解</option>
        <option value="calculation">计算题</option>
        <option value="application">应用题</option>
      </select>
    </div>

    <div class="space-y-4">
      <div
        v-for="question in questions"
        :key="question.id"
        class="p-4 border rounded-lg hover:bg-gray-50 transition-colors"
      >
        <div class="flex justify-between items-start">
          <div>
            <h4 class="font-medium">{{ question.title }}</h4>
            <div class="text-sm text-gray-500 mt-1">
              类型: {{ question.type }} | 难度: {{ question.difficulty }}
            </div>
          </div>
          <div class="text-sm text-gray-500">
            使用次数: {{ question.usageCount }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>