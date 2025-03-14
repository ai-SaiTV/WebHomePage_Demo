<template>
  <div class="dashboard">
    <el-card class="main-content">
      <h1>欢迎使用学生学习分析系统</h1>
      <p>请从下方选择功能</p>
      <div class="menu-buttons">
        <button @click="router.push('/Studylog')" class="btn btn-primary">学习日志</button>
        <button @click="router.push('/exam-analysis')" class="btn btn-secondary">个人ai学情分析</button>
      </div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { ElCard } from 'element-plus';
const router = useRouter();
</script>

<style scoped>

.dashboard {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #1890ff 0%, #36cfc9 100%);
}

.main-content {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 1.5rem;
  color: #000;
  width: 100%;
  max-width: 500px;
  text-align: center;
}

.main-content h1 {
  margin: 0;
  font-size: 2rem;
}

.main-content p {
  font-size: 1.2rem;
  opacity: 0.9;
}

.menu-buttons {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  width: 100%;
}

.menu-buttons button {
  padding: 1rem;
  font-size: 1.2rem;
  border: none;
  cursor: pointer;
  transition: 0.3s ease;
  width: 100%;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}

.btn-primary {
  background: linear-gradient(135deg, #4caf50 0%, #ffeb3b 100%);
  color: #fff;
}

.btn-secondary {
  background: linear-gradient(135deg, #f39c12 0%, #e53935 100%);
  color: #fff;
}

.menu-buttons button:hover {
  transform: scale(1.05);
  opacity: 0.9;
  box-shadow: 0 6px 15px rgba(0, 0, 0, 0.5);
}
</style>