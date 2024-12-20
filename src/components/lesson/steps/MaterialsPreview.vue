<script setup lang="ts">
import { ref } from 'vue';

const emit = defineEmits(['prev']);

const materials = ref([
  { type: 'ppt', title: '课程PPT', slides: 12, icon: '📊' },
  { type: 'worksheet', title: '练习题', questions: 10, icon: '📝' },
  { type: 'handout', title: '课程讲义', pages: 5, icon: '📄' },
]);
</script>

<template>
  <div class="space-y-6">
    <div class="space-y-4">
      <h3 class="text-lg font-medium">教学材料预览</h3>
      
      <div class="grid grid-cols-3 gap-4">
        <div
          v-for="material in materials"
          :key="material.title"
          class="p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors cursor-pointer"
        >
          <div class="text-3xl mb-2">{{ material.icon }}</div>
          <div class="font-medium">{{ material.title }}</div>
          <div class="text-sm text-gray-500">
            {{ material.slides ? material.slides + '页' : 
               material.questions ? material.questions + '题' :
               material.pages + '页' }}
          </div>
        </div>
      </div>
    </div>

    <div class="flex justify-between">
      <button
        @click="emit('prev')"
        class="px-6 py-2 text-gray-600 hover:text-gray-900"
      >
        上一步
      </button>
      <button
        class="px-6 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 transition-colors"
      >
        完成
      </button>
    </div>
  </div>
</template>