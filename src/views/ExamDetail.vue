<template>
  <div class="exam-detail">
    <div class="header">
      <button @click="router.push('/Exercise')" class="btn btn-secondary">返回</button>
    </div>
    <div class="detail-container white-card">
      <div class="detail-container white-card">
        <h2>错题详情</h2>
        <div class="wrong-questions">
          <img :src="examDetail?.details" alt="错题详情" @click="showPreview = true" />
        </div>
      </div>
    </div>

    <div v-if="showPreview" class="preview-modal" @click="showPreview = false">
      <img :src="examDetail?.details" alt="错题详情" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import type { ExamRecord } from '../types';

const router = useRouter();
const route = useRoute();
const showPreview = ref(false);

const examRecords = ref<ExamRecord[]>([
  {
    id: 1,
    date: '2024-03-15',
    subject: '数学',
    score: 95,
    details: 'https://dfiles.jiajiaoban.com/img/2019/03/29/094539_5c9d78c393fe2.png'
  },
  {
    id: 2,
    date: '2024-03-10',
    subject: '英语',
    score: 88,
    details: 'https://n.sinaimg.cn/sinakd20109/207/w1080h1527/20210526/6191-kqpyffz7008096.jpg'
  },
  {
    id: 3,
    date: '2024-03-15',
    subject: '数学',
    score: 88,
    details: 'https://tse1-mm.cn.bing.net/th/id/OIP-C.pIKc2obM9KHrBVc1Ml2YHQHaHJ?rs=1&pid=ImgDetMain'
  }
]);

const examDetail = computed(() => {
  const id = Number(route.params.id);
  return examRecords.value.find(exam => exam.id === id);
});
</script>

<style scoped>
.header {
  display: flex;
  justify-content: flex-end;
  padding: 1rem;
}

.detail-container {
  max-width: 800px;
  margin: 0 auto;
}

.wrong-questions img {
  width: 100%;
  height: auto;
  cursor: pointer;
}

.preview-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  cursor: pointer;
  
  img {
    max-width: 90%;
    max-height: 90vh;
  }
}
</style>