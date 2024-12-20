<script setup lang="ts">
defineProps<{
  title: string;
  icon: string;
}>();
</script>

<template>
  <button
    class="bg-white p-6 rounded-lg shadow-sm hover:shadow-md transition-shadow flex flex-col items-center justify-center gap-4 border border-gray-100"
  >
    <span class="text-4xl">{{ icon }}</span>
    <h3 class="text-lg font-medium text-gray-900">{{ title }}</h3>
  </button>
</template>