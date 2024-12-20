<script setup lang="ts">
defineProps<{
  steps: Array<{ title: string; description: string }>;
  currentStep: number;
}>();
</script>

<template>
  <div class="flex justify-between">
    <div
      v-for="(step, index) in steps"
      :key="index"
      class="flex items-center"
    >
      <!-- Step circle -->
      <div
        class="w-8 h-8 rounded-full flex items-center justify-center text-sm font-medium"
        :class="index <= currentStep ? 'bg-[#3451b2] text-white' : 'bg-gray-100 text-gray-500'"
      >
        {{ index + 1 }}
      </div>
      
      <!-- Step info -->
      <div class="ml-3" :class="index === steps.length - 1 ? '' : 'flex-1'">
        <div class="text-sm font-medium" :class="index <= currentStep ? 'text-[#3451b2]' : 'text-gray-500'">
          {{ step.title }}
        </div>
        <div class="text-xs text-gray-500">{{ step.description }}</div>
      </div>

      <!-- Connector line -->
      <div
        v-if="index < steps.length - 1"
        class="flex-1 mx-4 h-[2px]"
        :class="index < currentStep ? 'bg-[#3451b2]' : 'bg-gray-200'"
      ></div>
    </div>
  </div>
</template>