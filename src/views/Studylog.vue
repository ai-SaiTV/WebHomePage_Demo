<template>
  <div class="study-log">
    <div class="header">
      <button @click="router.push('/dashboard')" class="btn btn-secondary">返回</button>
    </div>
    <div v-for="log in studyLogs" :key="log.year">
      <h2>{{ log.year }}</h2>
      <div v-for="entry in log.entries" :key="entry.date">
        <h3>{{ entry.date }}</h3>
        <div class="log-entry" v-for="item in entry.items" :key="item.time">
          ·<span class="log-time-text">{{ item.time }}</span>
          <div :class="['log-item', item.type === 'exam' ? 'exam' : 'exercise']">
            <span> {{ item.type === 'exam' ? '试卷' : '练习题' }}</span>
          </div>
          <div class="log-detail" @click="navigateToDetail(item.id)">
            {{ item.name }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';

const router = useRouter();

const studyLogs = [
  {
    year: '2024',
    entries: [
      {
        date: '11月21日 星期一',
        items: [
          { time: '11:21', type: 'exam', name: '三角函数', id: 1 }
        ]
      },
      {
        date: '11月23日 星期三',
        items: [
          { time: '10:21', type: 'exercise', name: '四则运算', id: 2 },
          { time: '13:41', type: 'exam', name: '勾股定理', id: 3 }
        ]
      }
    ]
  }
];

const navigateToDetail = (id: number) => {
  router.push(`/exam-detail/${id}`);
};
</script>

<style scoped>
.header {
  display: flex;
  justify-content: flex-end;
  padding: 1rem;
}
.study-log {
  padding: 2rem;
}

h2 {
  margin-bottom: 1rem;
}

h3 {
  margin-bottom: 0.5rem;
}

.log-entry {
  margin-bottom: 1rem;
}

.log-item {
  padding: 0.10rem;
  margin-bottom: 0.25rem;
  border-radius: 4px;
  font-weight: bold;
  display: inline-block;
}

.exam {
  color: cyan;
  border: 2px solid cyan;
}

.exercise {
  color: purple;
  border: 2px solid purple;
}

.log-detail {
  cursor: pointer;
  background-color: #f0f0f0;
  padding: 0.5rem;
  border-radius: 4px;
  width: 100%;
  text-align: left;
}
.log-time-text {
  color: gray;
}
</style>