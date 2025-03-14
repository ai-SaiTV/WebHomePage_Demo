import { createRouter, createWebHistory } from 'vue-router';
import Login from '../views/Login.vue';
import Dashboard from '../views/Dashboard.vue';
import Studylog from '../views/Studylog.vue';
import ExamAnalysis from '../views/ExamAnalysis.vue';
import ExamDetail from '../views/ExamDetail.vue';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: Login
    },
    { 
      path: '/dashboard', 
      component: Dashboard 
    },
    { 
      path: '/Studylog', 
      component: Studylog 
    },
    { 
      path: '/exam-analysis', 
      component: ExamAnalysis 
    },
    { 
      path: '/exam-detail/:id', 
      component: ExamDetail 
    },
  ],
});

export default router;