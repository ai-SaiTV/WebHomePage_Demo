<script setup lang="ts">
import { ref } from 'vue';

const emit = defineEmits(['next', 'prev']);

const resources = ref([
  { type: 'video', title: '概念讲解视频', duration: '5:30', icon: '🎥' },
  { type: 'image', title: '知识点图解', format: 'PNG', icon: '🖼️' },
  { type: 'document', title: '课堂练习题', pages: 2, icon: '📝' },
]);
</script>

<template>
  <div class="space-y-6">
    <div class="space-y-4">
      <h3 class="text-lg font-medium">推荐教学资源</h3>
      
      <div class="grid grid-cols-3 gap-4">
        <div
          v-for="resource in resources"
          :key="resource.title"
          class="p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors cursor-pointer"
        >
          <div class="text-3xl mb-2">{{ resource.icon }}</div>
          <div class="font-medium">{{ resource.title }}</div>
          <div class="text-sm text-gray-500">
            {{ resource.duration || resource.format || resource.pages + '页' }}
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
        @click="emit('next')"
        class="px-6 py-2 bg-[#3451b2] text-white rounded-lg hover:bg-[#2d469d] transition-colors"
      >
        下一步
      </button>
    </div>
  </div>
</template>