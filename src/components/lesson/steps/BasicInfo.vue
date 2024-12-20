<script setup lang="ts">
import { ref } from 'vue';

const emit = defineEmits(['next', 'prev']);

const formData = ref({
  title: '',
  subject: '',
  grade: '',
  duration: 45,
  difficulty: 'medium'
});
</script>

<template>
  <div class="space-y-6">
    <div class="space-y-4">
      <div>
        <label class="block text-sm font-medium text-gray-700">课程标题</label>
        <input
          v-model="formData.title"
          type="text"
          class="mt-1 w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
          placeholder="请输入课程标题"
        />
      </div>
      
      <div class="grid grid-cols-2 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700">学科</label>
          <input
            v-model="formData.subject"
            type="text"
            class="mt-1 w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
            placeholder="请选择学科"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700">年级</label>
          <input
            v-model="formData.grade"
            type="text"
            class="mt-1 w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-[#3451b2] focus:border-transparent"
            placeholder="请选择年级"
          />
        </div>
      </div>
    </div>

    <div class="flex justify-end">
      <button
        @click="emit('next')"
        class="px-6 py-2 bg-[#3451b2] text-white rounded-lg hover:bg-[#2d469d] transition-colors"
      >
        下一步
      </button>
    </div>
  </div>
</template>