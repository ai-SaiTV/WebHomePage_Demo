import { createRouter, createWebHistory } from 'vue-router';
import Login from '../views/Login.vue';
import ExamDetail from '../views/ExamDetail.vue';
import AppLayout from '../components/AppLayout.vue'
import Performance from '../views/Performance.vue';
import Exercise from '../views/Exercise.vue';
const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: Login
    },
    {
      path: '/',
      component: AppLayout,
      children: [
        { 
          path: '/Performance', 
          component: Performance 
        },
        { 
          path: '/Exercise', 
          component: Exercise 
        },
        { 
          path: '/Exercise/:id', 
          component: ExamDetail 
        },
      ]
    },
    
  ],
});

export default router;