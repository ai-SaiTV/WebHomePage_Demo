<script setup lang="ts">
import { ref } from 'vue';

const tabs = [
  { id: 'lesson', label: '教学设计', icon: '📝' },
  { id: 'resources', label: '教学资源', icon: '📚' },
  { id: 'exercises', label: '练习题库', icon: '✍️' },
  { id: 'analytics', label: '学情分析', icon: '📊' },
];

const activeTab = ref('lesson');
</script>

<template>
  <div class="flex h-screen">
    <!-- Left sidebar with tabs -->
    <div class="w-64 bg-[#f9fafb] border-r border-gray-200">
      <div class="p-4">
        <h1 class="text-lg font-bold text-[#3451b2]">AI教学助手</h1>
      </div>
      <nav class="space-y-1 px-2">
        <button
          v-for="tab in tabs"
          :key="tab.id"
          @click="activeTab = tab.id"
          :class="[
            'w-full flex items-center px-3 py-2 text-sm rounded-lg transition-colors',
            activeTab === tab.id
              ? 'bg-[#e6ebf9] text-[#3451b2] font-medium'
              : 'text-gray-600 hover:bg-gray-100'
          ]"
        >
          <span class="mr-2">{{ tab.icon }}</span>
          {{ tab.label }}
        </button>
      </nav>
    </div>

    <!-- Main content area -->
    <div class="flex-1 overflow-auto">
      <slot :active-tab="activeTab" />
    </div>
  </div>
</template>