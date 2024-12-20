<script setup lang="ts">
import ResourceCard from './ResourceCard.vue';
import { ref } from 'vue';

const categories = [
  { id: 'videos', title: '教学视频', icon: '🎥' },
  { id: 'textbooks', title: '教科书', icon: '📚' },
  { id: 'exercises', title: '练习题集', icon: '📝' }
];

const selectedCategory = ref('');
</script>

<template>
  <div class="p-6 max-w-6xl mx-auto">
    <h2 class="text-2xl font-bold text-gray-900 mb-6">教学资源库</h2>
    
    <div v-if="!selectedCategory" class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <ResourceCard
        v-for="category in categories"
        :key="category.id"
        :title="category.title"
        :icon="category.icon"
        @click="selectedCategory = category.id"
      />
    </div>

    <div v-else class="bg-white rounded-lg shadow-sm p-6">
      <button
        @click="selectedCategory = ''"
        class="mb-4 text-[#3451b2] hover:text-[#2d469d] flex items-center"
      >
        ← 返回
      </button>
      <component
        :is="() => import(`./categories/${selectedCategory}/index.vue`)"
      />
    </div>
  </div>
</template>