<script setup lang="ts">
import { ref } from 'vue';
import type { ErrorType } from '../../types';

const props = defineProps<{
  errorStats: ErrorType[];
}>();

const emit = defineEmits(['generate']);

const formData = ref({
  count: 10,
  difficulty: 'medium',
  types: ['choice', 'fill'],
  focusAreas: props.errorStats.map(stat => stat.type)
});

const handleSubmit = () => {
  emit('generate', formData.value);
};
</script>

<template>
  <div class="bg-white rounded-lg shadow-sm p-6">
    <h3 class="text-lg font-medium mb-6">生成练习题</h3>
    
    <div class="space-y-6">
      <div class="grid grid-cols-2 gap-6">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">
            题目数量
          </label>
          <input
            v-model="formData.count"
            type="number"
            min="1"
            max="50"
            class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">
            难度级别
          </label>
          <select
            v-model="formData.difficulty"
            class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
          >
            <option value="easy">简单</option>
            <option value="medium">中等</option>
            <option value="hard">困难</option>
          </select>
        </div>
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700 mb-2">
          重点关注领域
        </label>
        <div class="space-y-2">
          <label
            v-for="stat in errorStats"
            :key="stat.type"
            class="flex items-center space-x-2"
          >
            <input
              type="checkbox"
              v-model="formData.focusAreas"
              :value="stat.type"
              class="rounded text-[#3451b2] focus:ring-[#3451b2]"
            />
            <span>{{ stat.type }} ({{ stat.percentage }}%)</span>
          </label>
        </div>
      </div>

      <button
        @click="handleSubmit"
        class="w-full px-6 py-2 bg-[#3451b2] text-white rounded-lg hover:bg-[#2d469d] transition-colors"
      >
        生成练习题
      </button>
    </div>
  </div>
</template>