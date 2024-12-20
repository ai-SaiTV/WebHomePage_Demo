<script setup lang="ts">
import { ref } from 'vue';
import type { Resource } from '../types';

const resources = ref<Resource[]>([]);

const generateResources = async () => {
  // TODO: Integrate with AI service to generate multimedia resources
  console.log('Generating resources...');
};
</script>

<template>
  <div class="p-6">
    <h2 class="text-2xl font-bold mb-4">教学资源生成器</h2>
    <div class="space-y-4">
      <button
        @click="generateResources"
        class="bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600"
      >
        生成教学资源
      </button>
      <div class="grid grid-cols-3 gap-4">
        <div
          v-for="resource in resources"
          :key="resource.id"
          class="border rounded-lg p-4"
        >
          <h3 class="font-semibold">{{ resource.title }}</h3>
          <p class="text-sm text-gray-600">{{ resource.type }}</p>
        </div>
      </div>
    </div>
  </div>
</template>