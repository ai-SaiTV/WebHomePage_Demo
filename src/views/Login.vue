<template>
  <div class="gradient-bg flex-center">
    <div class="white-card login-form">
      <h2>学生学习分析系统</h2>
      <div class="form-group">
        <input v-model="username" type="text" placeholder="用户名" @input="updateInputColor($event)" />
      </div>
      <div class="form-group">
        <input v-model="password" type="password" placeholder="密码" @input="updateInputColor($event)" />
      </div>
      <div class="button-group">
        <button @click="handleLogin" class="btn btn-primary">登录</button>
        <button @click="handleRegister" class="btn btn-secondary">注册</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '../store/auth';

const router = useRouter();
const authStore = useAuthStore();

const username = ref('');
const password = ref('');

const handleLogin = () => {
  if (username.value && password.value) {
    authStore.login(username.value);
    router.push('/Exercise');
  }
};

const handleRegister = () => {
  if (username.value && password.value) {
    alert('注册成功！');
  }
};

const updateInputColor = (event: Event) => {
  const input = event.target as HTMLInputElement;
  input.style.color = 'black';
};
</script>

<style scoped>
.flex-center {
  display: flex;
  justify-content: center;
  align-items: center;
}

.login-form {
  width: 100%;
  max-width: 400px;
  text-align: center;
}

.form-group {
  margin: 1rem 0;
  background-color: white;
}

.form-group input {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ddd;
  background-color: #ddd;
  border-radius: 4px;
  color: #aaa; /* 默认颜色 */
}

.button-group {
  display: flex;
  gap: 1rem;
  justify-content: center;
  margin-top: 2rem;
}
</style>