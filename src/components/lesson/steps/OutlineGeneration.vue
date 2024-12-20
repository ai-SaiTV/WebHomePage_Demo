<script setup lang="ts">
import { ref } from 'vue';

const emit = defineEmits(['next', 'prev']);

const isGenerating = ref(false);
const outline = ref('');

const generateOutline = () => {
  isGenerating = true;
  // 模拟AI生成过程
  setTimeout(() => {
    outline.value = `1. 课程导入 (5分钟)
  - 通过生活实例引入主题
  - 激发学生学习兴趣

2. 知识讲解 (20分钟)
  - 核心概念解释
  - 重点难点分析
  - 案例演示

3. 互动练习 (15分钟)
  - 小组讨论
  - 实践操作
  - 答疑解惑

4. 总结提升 (5分钟)
  - 知识点回顾
  - 拓展思考
  - 布置作业`;
    isGenerating = false;
  }, 1500);
};
</script>

<template>
  <div class="space-y-6">
    <div class="space-y-4">
      <div class="flex justify-between items-center">
        <h3 class="text-lg font-medium">教学大纲生成</h3>
        <button
          @click="generateOutline"
          :disabled="isGenerating"
          class="px-4 py-2 bg-[#3451b2] text-white rounded-lg hover:bg-[#2d469d] transition-colors disabled:opacity-50"
        >
          {{ isGenerating ? '生成中...' : '生成大纲' }}
        </button>
      </div>

      <div class="bg-gray-50 rounded-lg p-4 min-h-[300px]">
        <pre class="whitespace-pre-wrap">{{ outline }}</pre>
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