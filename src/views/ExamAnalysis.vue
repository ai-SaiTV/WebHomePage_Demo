<template>
  <div class="analysis-container">
    <div class="header">
       <p2><button @click="generateStudentAnalysis(selectedStudent)" class="btn btn-primary">开始分析</button></p2>
       <p1><button @click="router.push('/Dashboard')" class="btn btn-secondary">返回</button></p1>
    </div>
    <StudentDetailsDialog
      :show="showStudentDetails"
      :student="selectedStudent"
      :analysis="studentAnalysis"
      :loading="isAnalyzing"
      @update:show="showStudentDetails = false"
    />
    
  </div>
</template>

<script setup lang="ts">
import { ref} from "vue";
import StudentDetailsDialog from '../components/StudentDetailsDialog.vue';
import { useRouter } from 'vue-router';

const router = useRouter();
interface Student {
  id: string;
  name: string;
  scores: number[];
  total: number;
  average: number;
  rank: number;
  class: string;
}

interface Question {
  maxScore: number;
  correctRate: number;
}


const showStudentDetails = ref(false);
const studentAnalysis = ref({
  strengths: [] as string[],
  weaknesses: [] as string[],
  recommendations: [] as string[],
});
const isAnalyzing = ref(false);

// 创建一个 Student 实例
const scores = [5, 10, 2, 5, 6, 4, 7, 8];
const total = scores.reduce((sum, score) => sum + score, 0);
const selectedStudent = ref<Student>({
  id: "230213",
  name: "李华",
  scores,
  total,
  average: total / scores.length,
  rank: 3,
  class: "数学"
});

// 创建一个 questions 实例
const questions = ref<Question[]>([
  { maxScore: 10, correctRate: 0.8 },
  { maxScore: 10, correctRate: 0.9 },
  { maxScore: 10, correctRate: 0.7 },
  { maxScore: 10, correctRate: 0.6 },
  { maxScore: 10, correctRate: 0.75 },
  { maxScore: 10, correctRate: 0.85 },
  { maxScore: 10, correctRate: 0.65 },
  { maxScore: 10, correctRate: 0.9 }
]);

// 生成学生个人分析
const generateStudentAnalysis = async (student: Student) => {
  isAnalyzing.value = true;

  await new Promise((resolve) => setTimeout(resolve, 1500));

  // 计算学生在每个题目的得分情况
  const studentScores = student.scores.map((score, index) => ({
    question: `题目${index + 1}`,
    score,
    maxScore: questions.value[index].maxScore,
    correctRate: questions.value[index].correctRate,
  }));

  // 优势分析：得分高于平均分的题目
  const strengths = studentScores
    .filter((q) => q.score > q.maxScore * 0.8)
    .map((q) => `${q.question}得分较高，为${q.score}分，表现优秀。`);

  // 待提升项：得分低于平均分的题目
  const weaknesses = studentScores
    .filter((q) => q.score < q.maxScore * 0.5)
    .map((q) => `${q.question}得分较低，为${q.score}分，需要加强练习。`);

  // 学习建议：针对待提升的题目提出建议
  const recommendations = [
    `针对得分较低的题目，建议多做相关练习题，巩固知识点。`,
    `保持在得分较高的题目的优势，继续提升解题技巧。`,
    `建议定期复习错题，总结解题思路，避免重复错误。`,
  ];

  studentAnalysis.value = {
    strengths,
    weaknesses,
    recommendations,
  };

  isAnalyzing.value = false;
};

// // 查看学生详情
// const viewStudentDetails = (student: Student) => {
//   selectedStudent.value = student;
//   showStudentDetails.value = true;
//   generateStudentAnalysis(student);
// };
</script>

<style scoped>
.header {
  display: flex;
  justify-content: space-between;
  padding: 1rem;
}
.p1, .p2 {
  margin: 0;
}
.p1 {
  align-self: flex-start;
}
.p2 {
  align-self: flex-start;
}
.analysis-container {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  padding: 1rem;
  }
.mt-4 {
  margin-top: 1rem;
  justify-content: center;
  align-items: center;
}
</style>