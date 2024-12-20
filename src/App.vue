<script setup lang="ts">
import TabNavigation from './components/layout/TabNavigation.vue';
import LessonPage from './components/lesson/LessonPage.vue';
import ResourcePage from './components/resources/ResourcePage.vue';
import ExerciseGenerator from './components/ExerciseGenerator.vue';
import AnalyticsPage from './components/analytics/AnalyticsPage.vue';
</script>

<template>
  <TabNavigation>
    <template #default="{ activeTab }">
      <component
        :is="
          activeTab === 'lesson'
            ? LessonPage
            : activeTab === 'resources'
            ? ResourcePage
            : activeTab === 'exercises'
            ? ExerciseGenerator
            : AnalyticsPage
        "
      />
    </template>
  </TabNavigation>
</template>