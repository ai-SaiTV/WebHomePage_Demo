<script setup lang="ts">
import { ref } from 'vue';
import LessonSteps from './steps/LessonSteps.vue';
import BasicInfo from './steps/BasicInfo.vue';
import OutlineGeneration from './steps/OutlineGeneration.vue';
import ResourceRecommendation from './steps/ResourceRecommendation.vue';
import MaterialsPreview from './steps/MaterialsPreview.vue';

const currentStep = ref(0);
const steps = [
  { title: '基本信息', description: '填写课程基本信息' },
  { title: '教学大纲', description: 'AI辅助生成教学大纲' },
  { title: '教学资源', description: '推荐相关教学资源' },
  { title: '教学材料', description: '预览生成的教学材料' }
];

const handleNext = () => {
  if (currentStep.value < steps.length - 1) {
    currentStep.value++;
  }
};

const handlePrev = () => {
  if (currentStep.value > 0) {
    currentStep.value--;
  }
};
</script>

<template>
  <div class="max-w-4xl mx-auto p-6">
    <div class="bg-white rounded-lg shadow-sm">
      <!-- Steps indicator -->
      <LessonSteps
        :steps="steps"
        :current-step="currentStep"
        class="p-6 border-b"
      />

      <!-- Step content -->
      <div class="p-6">
        <component
          :is="currentStep === 0 ? BasicInfo
            : currentStep === 1 ? OutlineGeneration
            : currentStep === 2 ? ResourceRecommendation
            : MaterialsPreview"
          @next="handleNext"
          @prev="handlePrev"
        />
      </div>
    </div>
  </div>
</template>