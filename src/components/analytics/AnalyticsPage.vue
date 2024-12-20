<script setup lang="ts">
import StudentList from './StudentList.vue';
import PerformanceChart from './PerformanceChart.vue';
import StudentDetail from './StudentDetail.vue';
import { ref } from 'vue';
import type { Student } from '../../types';

const selectedStudent = ref<Student | null>(null);
</script>

<template>
  <div class="p-6 grid grid-cols-12 gap-6 h-full">
    <!-- Performance Overview -->
    <div class="col-span-8 bg-white rounded-lg shadow-sm p-6">
      <h2 class="text-xl font-bold text-gray-900 mb-4">班级整体表现</h2>
      <PerformanceChart />
    </div>

    <!-- Student List -->
    <div class="col-span-4 bg-white rounded-lg shadow-sm p-6 flex flex-col">
      <h2 class="text-xl font-bold text-gray-900 mb-4">学生名单</h2>
      <StudentList
        class="flex-1 overflow-auto"
        @select="selectedStudent = $event"
        :selected-id="selectedStudent?.id"
      />
    </div>

    <!-- Student Detail Modal -->
    <StudentDetail
      v-if="selectedStudent"
      :student="selectedStudent"
      @close="selectedStudent = null"
    />
  </div>
</template>