<script setup lang="ts">
import { ref, computed, nextTick } from 'vue'
// 模拟题目数据
const questions = ref<Question[]>([
  //英语
  {
    "id": 1,
    "type": "choice",
    "content": "单项选择题\n Whose jeans are these?",
    "options": [
      "They're Linda's",
      "They are Linda",
      "It's Linda's"
    ],
    "answer": "They're Linda's",
    "analysis": "题目考查所有格的用法，表示“某人的某物”时需用所有格形式。正确答案是 'They're Linda's'，表示这些牛仔裤是Linda的。"
  },
  {
    "id": 2,
    "type": "choice",
    "content": "There __ beautiful flowers everywhere.",
    "options": [
      "are",
      "is",
      "Many"
    ],
    "answer": "are",
    "analysis": "本题考查主谓一致。主语 'beautiful flowers' 是复数，因此谓语动词需用复数形式 'are'。"
  },
  {
    "id": 3,
    "type": "text",
    "content": "用单词的适当形式填空。\n What can you ___________(do)",
    "answer": "do",
    "analysis": "题目考查情态动词的用法。情态动词 'can' 后跟动词原形，因此答案是 'do'。"
  },
  {
    "id": 4,
    "type": "choice",
    "content": "单项选择题\n This book is very _________.",
    "options": [
      "interest",
      "interesting",
      "interested"
    ],
    "answer": "interesting",
    "analysis": "考查形容词用法。形容事物本身具有吸引力时用 'interesting'；表示人的感受用 'interested'。本句描述书的特性，因此选择 'interesting'。"
  },
  {
    "id": 5,
    "type": "text",
    "content": "用正确形式填空。\n She __________(go) to school every day.",
    "answer": "goes",
    "analysis": "题目考查一般现在时主谓一致。主语 'She' 是第三人称单数，现在时动词需加 -s，因此答案是 'goes'。"
  },
  {
    "id": 6,
    "type": "choice",
    "content": "单项选择题\n How _______ milk do you want?",
    "options": [
      "many",
      "much",
      "a lot"
    ],
    "answer": "much",
    "analysis": "考查量词的使用。milk 是不可数名词，修饰不可数名词时用 'much'。"
  },
  {
    "id": 7,
    "type": "text",
    "content": "用单词的适当形式填空。\n The children __________(be) playing in the park.",
    "answer": "are",
    "analysis": "考查现在进行时的构成。主语 'The children' 是复数，be 动词需用复数形式 'are'，因此答案是 'are'。"
  },
  {
    "id": 8,
    "type": "choice",
    "content": "单项选择题\n She ______ in the library yesterday.",
    "options": [
      "is",
      "was",
      "were"
    ],
    "answer": "was",
    "analysis": "考查过去时态。主语 'She' 是第三人称单数，过去时需用 'was'。"
  },
  {
    "id": 9,
    "type": "text",
    "content": "用单词的适当形式填空。\n I like ____________(swim) in summer.",
    "answer": "swimming",
    "analysis": "考查动名词的用法。like 后常接动名词形式，表示喜欢做某事，因此答案是 'swimming'。"
  },

  //数学
  // {
  //   "id": 1,
  //   "type": "choice",
  //   "content": "一个两位数由三个不同的质数相乘得到，这个数的因数有几个?",
  //   "options": [
  //     "3",
  //     "8",
  //     "10"
  //   ],
  //   "answer": "8",
  //   "analysis": "若一个数由三个不同的质数相乘得到，则该数的因数个数为 (1+1)(1+1)(1+1)=8 个。"
  // },
  // {
  //   "id": 2,
  //   "type": "fill",
  //   "content": "四个连续自然数的积是840，那四个自然数的和是多少?",
  //   "answer": "26",
  //   "analysis": "设四个连续自然数为 n, n+1, n+2, n+3，则 n(n+1)(n+2)(n+3)=840，解得 n=3，因此四个自然数为 3, 4, 5, 6，它们的和为 18。"
  // },
  // {
  //   "id": 3,
  //   "type": "text",
  //   "content": "计算:\n1. 2.4+3.2*14-5/2",
  //   "answer": "44.7",
  //   "analysis": "先乘除后加减，\n3.2*14=44.8,\n5/2=2.5,\n2.4+44.8-2.5=44.7"
  // },
  // {
  //   "id": 4,
  //   "type": "choice",
  //   "content": "一个两位数由两个不同的质数相乘得到，这个数的因数有几个?",
  //   "options": [
  //     "4",
  //     "6",
  //     "8"
  //   ],
  //   "answer": "4",
  //   "analysis": "若一个数由两个不同的质数相乘得到，则该数的因数个数为 (1+1)(1+1)=4 个。"
  // },
  // {
  //   "id": 5,
  //   "type": "choice",
  //   "content": "质数 13、17、19 的和是多少?",
  //   "options": [
  //     "47",
  //     "49",
  //     "51"
  //   ],
  //   "answer": "49",
  //   "analysis": "13+17+19=49。"
  // },
  // {
  //   "id": 6,
  //   "type": "choice",
  //   "content": "求质数 2、3、5、7 的乘积。",
  //   "options": [
  //     "210",
  //     "231",
  //     "252"
  //   ],
  //   "answer": "210",
  //   "analysis": "2*3*5*7=210。"
  // },
  // {
  //   "id": 7,
  //   "type": "choice",
  //   "content": "一个三位数由两个不同的质数相乘得到，这个数的因数有几个?",
  //   "options": [
  //     "4",
  //     "6",
  //     "8"
  //   ],
  //   "answer": "4",
  //   "analysis": "若一个数由两个不同的质数相乘得到，则该数的因数个数为 (1+1)(1+1)=4 个。"
  // },
  // {
  //   "id": 8,
  //   "type": "text",
  //   "content": "计算：2^5 - 3^3",
  //   "answer": "29",
  //   "analysis": "2^5=32，3^3=27，32-27=5。"
  // },
  // {
  //   "id": 9,
  //   "type": "choice",
  //   "content": "质数 11、13、17 的乘积是多少?",
  //   "options": [
  //     "2431",
  //     "2413",
  //     "2341"
  //   ],
  //   "answer": "2431",
  //   "analysis": "11*13*17=2431。"
  // },
  // {
  //   "id": 10,
  //   "type": "choice",
  //   "content": "一个两位数由三个不同的质数相乘得到，这个数的因数有几个?",
  //   "options": [
  //     "6",
  //     "8",
  //     "10"
  //   ],
  //   "answer": "8",
  //   "analysis": "若一个数由三个不同的质数相乘得到，则该数的因数个数为 (1+1)(1+1)(1+1)=8 个。"
  // },
  // {
  //   "id": 11,
  //   "type": "text",
  //   "content": "计算：5*7 + 11 - 2^3",
  //   "answer": "40",
  //   "analysis": "5*7=35，2^3=8，35+11-8=38。"
  // }
  //语文
  // {
  //   id: 1,
  //   type: 'choice',
  //   content: '下列句子中，标点符号运用有误的一项是',
  //   options: [
  //     '我心里又害怕又奇怪：一幅画而已，有什么稀罕的呢？',
  //     '诸葛亮吩咐军士们齐声高喊“谢谢曹丞相的箭”。',
  //     '“我确实一个铜板都没有存，想从我这里发洋财，是想错了。”我微笑着，淡淡地说。',
  //     '沉睡的牲畜、无声的低地、漆黑的夜晚，只有远处的几座灯塔在闪烁微弱的光芒。'
  //   ],
  //   answer: '诸葛亮吩咐军士们齐声高喊“谢谢曹丞相的箭”。',
  //   analysis: '具体来说，在“齐声高喊”之后应该有引号，表示这是诸葛亮的直接引语。'
  // },
  // {
  //   id: 2,
  //   type: 'fill',
  //   content: '老李决心改正自己身上不正确的缺点。（修改病句）',
  //   answer: '老李决心改正自己身上的缺点。',
  //   analysis: '缺点与不正确是重复的，去掉一个即可。'
  // },
  // {
  //   id: 3,
  //   type: 'text',
  //   content: '浪涛拍打着海岸。（加上适当的修饰语，使句子表达更具体、更生动）',
  //   answer: '澎湃的浪涛猛烈地拍打着崎岖的海岸。',
  //   analysis: '考察学生对于句子结构的理解'
  // },
  // {
  //   id: 4,
  //   type: 'text',
  //   content: '计算:\n 1. 2.4+3.2*14-5/2',
  //   answer: '44.7',
  //   analysis: ' 先乘除后加减，\n 3.2*14=44.8,\n 5/2=2.5,\n 2.4+44.8-2.5=44.7'

  // },
  // {
  //   id: 5,
  //   type: 'text',
  //   content: '计算:\n 1. 2.4+3.2*14-5/2',
  //   answer: '44.7',
  //   analysis: ' 先乘除后加减，\n 3.2*14=44.8,\n 5/2=2.5,\n 2.4+44.8-2.5=44.7'
  // },
  // {
  //   id: 6,
  //   type: 'text',
  //   content: '计算:\n 1. 2.4+3.2*14-5/2',
  //   answer: '44.7',
  //   analysis: ' 先乘除后加减，\n 3.2*14=44.8,\n 5/2=2.5,\n 2.4+44.8-2.5=44.7'
  // },
  // {
  //   id: 7,
  //   type: 'text',
  //   content: '计算:\n 1. 2.4+3.2*14-5/2',
  //   answer: '44.7',
  //   analysis: ' 先乘除后加减，\n 3.2*14=44.8,\n 5/2=2.5,\n 2.4+44.8-2.5=44.7'

  // },
  // {
  //   id: 8,
  //   type: 'text',
  //   content: '计算:\n 1. 2.4+3.2*14-5/2',
  //   answer: '44.7',
  //   analysis: ' 先乘除后加减，\n 3.2*14=44.8,\n 5/2=2.5,\n 2.4+44.8-2.5=44.7'

  // }
])
const errorquestions = ref<Question[]>([
  //语文
  // {
  //   id: 1,
  //   type: 'choice',
  //   content: '下列句子没有语病的一项是(　　 )',
  //   options: [
  //     '衣服并不合身，但是一点儿也不好看，而且是新的。',
  //     '这本书的内容很有趣，读起来很容易。',
  //     '这道题的答案是错的。',
  //   ],
  //   answer: '衣服并不合身，但是一点儿也不好看，而且是新的。',
  //   analysis: ''
  // },
  // {
  //   id: 2,
  //   type: 'fill',
  //   content: '我们要学会把不正确的错别字改正过来。（修改病句）',
  //   answer: '168',
  //   analysis: '28,42,56的最小公倍数是168'
  // },
  // {
  //   id: 3,
  //   type: 'text',
  //   content: '小说《钢铁是怎样炼成的》刻画了英雄保尔·柯察金的故事。（修改病句）',
  //   answer: '30',
  //   analysis: ' 例如：2*3*5=30,\n 30的因数有1,2,3,5,6,10,15,30共8个'
  // }
  //英语
  {
    "id": 1,
    "type": "choice",
    "content": "单项选择题\n ______ you help me with my homework?",
    "options": [
      "Do",
      "Can",
      "Are"
    ],
    "answer": "Can",
    "analysis": "考查情态动词的用法。'Can' 表示请求或能力，因此答案是 'Can'。"
  },
  {
    "id": 2,
    "type": "choice",
    "content": "单项选择题\n He always _______ up early in the morning.",
    "options": [
      "gets",
      "get",
      "getting"
    ],
    "answer": "gets",
    "analysis": "考查一般现在时主谓一致。主语 'He' 是第三人称单数，谓语动词需加 -s，因此答案是 'gets'。"
  },
  {
    "id": 3,
    "type": "choice",
    "content": "单项选择题\n How _______ milk do you want?",
    "options": [
      "many",
      "much",
      "a lot"
    ],
    "answer": "much",
    "analysis": "考查量词的使用。milk 是不可数名词，修饰不可数名词时用 'much'。"
  },
]);
interface Exercise {
  id: string
  title: string
  subject: string
  difficulty: string
  questionCount: number
  timeLimit: number
  status: 'not_started' | 'in_progress' | 'completed'
  score?: number
  questions?: Question[]
}

interface Question {
  id: number
  type: string
  content: string
  options?: string[]
  answer?: string
  userAnswer?: string
  score?: number
  analysis?: string
}

const exercises = ref<Exercise[]>([
  {
    id: '1',
    title: '英语句子分析练习',
    subject: '英语',
    difficulty: '中等',
    questionCount: 10,
    timeLimit: 30,
    status: 'not_started',
    questions: questions.value
  },
  {
    id: '2',
    title: '几何图形基础练习',
    subject: '数学',
    difficulty: '简单',
    questionCount: 15,
    timeLimit: 45,
    status: 'completed',
    score: 92,
    questions: questions.value
  },
  {
    id: '3',
    title: '方程式解法练习',
    subject: '数学',
    difficulty: '较难',
    questionCount: 8,
    timeLimit: 25,
    status: 'in_progress',
    questions: questions.value
  }
])




const activeTab = ref('all')
const searchKeyword = ref('')
const exerciseDialogVisible = ref(false)
const reportDialogVisible = ref(false)
const selectedExercise = ref<Exercise | null>(null)
const currentQuestionIndex = ref(0)
const userAnswers = ref<Record<number, string>>({})
const timeRemaining = ref(0)
const timer = ref<number | null>(null)
const questionsContainer = ref<HTMLElement | null>(null)
const loadingDialogVisible = ref(false)

const filteredExercises = computed(() => {
  return exercises.value.filter(exercise => {
    const matchesSearch = exercise.title.toLowerCase().includes(searchKeyword.value.toLowerCase()) ||
      exercise.subject.toLowerCase().includes(searchKeyword.value.toLowerCase())

    if (activeTab.value === 'all') return matchesSearch
    if (activeTab.value === 'not_started') return exercise.status === 'not_started' && matchesSearch
    if (activeTab.value === 'in_progress') return exercise.status === 'in_progress' && matchesSearch
    if (activeTab.value === 'completed') return exercise.status === 'completed' && matchesSearch

    return false
  })
})

// const currentQuestion = computed(() => {
//   return questions.value[currentQuestionIndex.value]
// })

const progress = computed(() => {
  const q = selectedExercise.value?.questions || []
  return {
    percentage: (currentQuestionIndex.value + 1) / q.length * 100,
    text: `${currentQuestionIndex.value + 1}/${q.length}`
  }
})

const formattedTime = computed(() => {
  const minutes = Math.floor(timeRemaining.value / 60)
  const seconds = timeRemaining.value % 60
  return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`
})

const getDifficultyTag = (difficulty: string) => {
  switch (difficulty) {
    case '简单':
      return 'success'
    case '中等':
      return 'warning'
    case '较难':
      return 'danger'
    default:
      return 'info'
  }
}

const getStatusTag = (status: string) => {
  switch (status) {
    case 'not_started':
      return { type: 'info', label: '未开始' }
    case 'in_progress':
      return { type: 'warning', label: '进行中' }
    case 'completed':
      return { type: 'success', label: '已完成' }
    default:
      return { type: 'info', label: '未知' }
  }
}

const startExercise = (exercise: Exercise) => {
  selectedExercise.value = exercise
  exerciseDialogVisible.value = true
  currentQuestionIndex.value = 0
  userAnswers.value = {}
  timeRemaining.value = exercise.timeLimit * 60
  startTimer()
}

const continueExercise = (exercise: Exercise) => {
  selectedExercise.value = exercise
  exerciseDialogVisible.value = true
  // 这里可以加载已保存的答案和进度
}

const viewReport = (exercise: Exercise) => {
  selectedExercise.value = exercise
  reportDialogVisible.value = true
}

const submitAnswer = () => {
  finishExercise()
}
const Errorgeneration = () => {
  reportDialogVisible.value = false
  loadingDialogVisible.value = true
  setTimeout(() => {
    exercises.value.unshift({
      id: '4',
      title: '错题练习',
      subject: '语文',
      difficulty: '中等',
      questionCount: errorquestions.value.length,
      timeLimit: 30,
      status: 'not_started',
      questions: errorquestions.value
    })
    selectedExercise.value = exercises.value[0]
    loadingDialogVisible.value = false
  }, 2000
  )
}
const scrollToQuestion = (questionId: number) => {
  if (!questionsContainer.value) return

  nextTick(() => {
    const questionElement = document.getElementById(`question-${questionId}`)
    currentQuestionIndex.value = questions.value.findIndex(question => question.id === questionId)
    if (questionElement) {
      questionElement.scrollIntoView({ behavior: 'smooth', block: 'start' })
    }
  })
}

const finishExercise = () => {
  if (timer.value) {
    clearInterval(timer.value)
    timer.value = null
  }

  // 计算得分
  let correctCount = 0
  const q = selectedExercise.value?.questions || []
  q.forEach(q => {
    if (userAnswers.value[q.id] === q.answer) {
      correctCount++
    }
  })

  const score = Math.round((correctCount / q.length) * 100)

  // 更新练习状态
  if (selectedExercise.value) {
    selectedExercise.value.status = 'completed'
    selectedExercise.value.score = score
  }

  exerciseDialogVisible.value = false
  viewReport(selectedExercise.value!)
}

const startTimer = () => {
  timer.value = setInterval(() => {
    if (timeRemaining.value > 0) {
      timeRemaining.value--
    } else {
      finishExercise()
    }
  }, 1000) as unknown as number
}

const closeExercise = () => {
  if (timer.value) {
    clearInterval(timer.value)
    timer.value = null
  }
  exerciseDialogVisible.value = false
}
</script>

<template>
  <div class="exercise-container">
    <!-- 页面标题和搜索栏 -->
    <div class="page-header">
      <div class="header-left">
        <h2>在线练习</h2>
        <p class="subtitle">选择合适的练习提升能力</p>
      </div>
      <div class="header-right">
        <el-input v-model="searchKeyword" placeholder="搜索练习" prefix-icon="Search" clearable />
      </div>
    </div>

    <!-- 练习统计卡片 -->
    <el-row :gutter="20" class="stat-row">
      <el-col :span="8">
        <el-card class="stat-card">
          <div class="stat-content">
            <el-icon class="stat-icon" color="#1890ff">
              <Edit />
            </el-icon>
            <div class="stat-info">
              <div class="stat-value">12</div>
              <div class="stat-label">今日练习题数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="stat-card">
          <div class="stat-content">
            <el-icon class="stat-icon" color="#52c41a">
              <CircleCheckFilled />
            </el-icon>
            <div class="stat-info">
              <div class="stat-value">85%</div>
              <div class="stat-label">正确率</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="stat-card">
          <div class="stat-content">
            <el-icon class="stat-icon" color="#722ed1">
              <Timer />
            </el-icon>
            <div class="stat-info">
              <div class="stat-value">45</div>
              <div class="stat-label">练习时长(分钟)</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 练习列表 -->
    <el-card class="exercise-list-card">
      <template #header>
        <div class="card-header">
          <el-tabs v-model="activeTab">
            <el-tab-pane label="全部练习" name="all" />
            <el-tab-pane label="未开始" name="not_started" />
            <el-tab-pane label="进行中" name="in_progress" />
            <el-tab-pane label="已完成" name="completed" />
          </el-tabs>
        </div>
      </template>

      <div class="exercise-list">
        <div v-for="exercise in filteredExercises" :key="exercise.id" class="exercise-item">
          <div class="exercise-info">
            <h3>{{ exercise.title }}</h3>
            <div class="exercise-tags">
              <el-tag size="small">{{ exercise.subject }}</el-tag>
              <el-tag size="small" :type="getDifficultyTag(exercise.difficulty)">
                {{ exercise.difficulty }}
              </el-tag>
              <el-tag size="small" :type="getStatusTag(exercise.status).type">
                {{ getStatusTag(exercise.status).label }}
              </el-tag>
            </div>
            <div class="exercise-details">
              <span>
                <el-icon>
                  <Document />
                </el-icon>
                {{ exercise.questionCount }}题
              </span>
              <span>
                <el-icon>
                  <Timer />
                </el-icon>
                {{ exercise.timeLimit }}分钟
              </span>
              <span v-if="exercise.score !== undefined">
                <el-icon>
                  <DataLine />
                </el-icon>
                得分：{{ exercise.score }}
              </span>
            </div>
          </div>
          <div class="exercise-actions">
            <template v-if="exercise.status === 'not_started'">
              <el-button type="primary" @click="startExercise(exercise)">
                开始练习
              </el-button>
            </template>
            <template v-else-if="exercise.status === 'in_progress'">
              <el-button type="warning" @click="continueExercise(exercise)">
                继续练习
              </el-button>
            </template>
            <template v-else>
              <el-button type="success" @click="viewReport(exercise)">
                查看报告
              </el-button>
            </template>
          </div>
        </div>
      </div>
    </el-card>

    <!-- 练习对话框 -->
    <el-dialog v-model="exerciseDialogVisible" :title="selectedExercise?.title" width="50%"
      :close-on-click-modal="false" :before-close="closeExercise">
      <div class="exercise-dialog">
        <!-- 进度条和计时器 -->
        <div class="exercise-header">
          <el-progress :percentage="progress.percentage" :format="() => progress.text" class="progress" />
          <div class="timer">
            <el-icon>
              <Timer />
            </el-icon>
            {{ formattedTime }}
          </div>
        </div>

        <!-- 题目内容区域（可滚动） -->
        <div class="questions-container" ref="questionsContainer">
          <div v-for="(question, index) in selectedExercise?.questions" :key="question.id" class="question-content"
            :id="`question-${question.id}`">
            <h3>第 {{ index + 1 }} 题</h3>
            <p class="question-text">{{ question.content }}</p>

            <!-- 选择题 -->
            <template v-if="question.type === 'choice'">
              <el-radio-group v-model="userAnswers[question.id]" @click="scrollToQuestion(question.id)">
                <el-radio v-for="option in question.options" :key="option" :label="option" class="question-option">
                  {{ option }}
                </el-radio>
              </el-radio-group>
            </template>

            <!-- 填空题 -->
            <template v-else-if="question.type === 'fill'">
              <el-input v-model="userAnswers[question.id]" placeholder="请输入答案" @focus="scrollToQuestion(question.id)" />
            </template>

            <!-- 解答题 -->
            <template v-else-if="question.type === 'text'">
              <el-input v-model="userAnswers[question.id]" type="textarea" :rows="4" placeholder="请输入答案"
                @focus="scrollToQuestion(question.id)" />
            </template>
          </div>
        </div>

        <!-- 提交按钮 -->
        <div class="submit-button">
          <el-button type="primary" @click="submitAnswer">
            提交
          </el-button>
        </div>
      </div>
    </el-dialog>

    <!-- 报告对话框 -->
    <el-dialog v-model="reportDialogVisible" title="练习报告" width="50%">
      <div class="report-dialog">
        <!-- 总体得分 -->
        <div class="score-section">
          <div class="score-circle">
            <h2>{{ selectedExercise?.score }}</h2>
            <p>总分</p>
          </div>
          <div class="score-stats">
            <div class="stat-item">
              <span class="label">用时</span>
              <span class="value">{{ selectedExercise?.timeLimit }}分钟</span>
            </div>
            <div class="stat-item">
              <span class="label">题目数</span>
              <span class="value">{{ questions.length }}题</span>
            </div>
            <div class="stat-item">
              <span class="label">正确率</span>
              <span class="value">{{ selectedExercise?.score }}%</span>
            </div>
          </div>
        </div>

        <!-- 题目分析（可滚动） -->
        <div class="questions-analysis">
          <div class="header-right">
            <button @click="Errorgeneration"> 错题生成</button>
          </div>
          <h3>题目分析</h3>
          <div class="questions-analysis-container">
            <div v-for="question in selectedExercise?.questions" :key="question.id" class="question-item">
              <div class="question-header">
                <span class="question-number">第{{ question.id }}题</span>
                <el-tag :type="userAnswers[question.id] === question.answer ? 'success' : 'danger'" size="small">
                  {{ userAnswers[question.id] === question.answer ? '正确' : '错误' }}
                </el-tag>
              </div>
              <p class="question-content">{{ question.content }}</p>
              <div class="answer-section">
                <p>
                  <span class="label">你的答案：</span>
                  <span :class="{ 'wrong-answer': userAnswers[question.id] !== question.answer }">
                    {{ userAnswers[question.id] || '未作答' }}
                  </span>
                </p>
                <p>
                  <span class="label">正确答案：</span>
                  <span class="correct-answer">{{ question.answer }}</span>
                </p>
              </div>
              <div class="analysis-section">
                <p class="label">解析：</p>
                <p class="analysis-content">{{ question.analysis }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </el-dialog>

    <!-- Loading 对话框 -->
    <el-dialog v-model="loadingDialogVisible" title="生成错题中" width="30%" :close-on-click-modal="false"
      :show-close="false">
      <div class="loading-dialog">
        <el-loading type="circle" />
        <p>正在生成中....</p>
      </div>
    </el-dialog>
  </div>
</template>

<style scoped lang="scss">
.exercise-container {
  .page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;

    .header-left {
      h2 {
        margin: 0;
        font-size: 24px;
        color: #1f2937;
      }

      .subtitle {
        margin: 4px 0 0;
        color: #6b7280;
      }
    }

    .header-right {
      .el-input {
        width: 240px;
      }
    }
  }

  .stat-row {
    margin-bottom: 24px;

    .stat-card {
      .stat-content {
        display: flex;
        align-items: center;
        padding: 20px;

        .stat-icon {
          font-size: 48px;
          margin-right: 20px;
        }

        .stat-info {
          .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #1f2937;
          }

          .stat-label {
            margin-top: 4px;
            color: #6b7280;
          }
        }
      }
    }
  }

  .exercise-list-card {
    .exercise-list {
      max-height: 60vh;
      overflow-y: auto;

      .exercise-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px;
        border-bottom: 1px solid #e5e7eb;

        &:last-child {
          border-bottom: none;
        }

        .exercise-info {
          flex: 1;

          h3 {
            margin: 0 0 8px;
            font-size: 16px;
            color: #1f2937;
          }

          .exercise-tags {
            margin-bottom: 8px;

            .el-tag {
              margin-right: 8px;
            }
          }

          .exercise-details {
            color: #6b7280;
            font-size: 14px;

            span {
              display: inline-flex;
              align-items: center;
              margin-right: 16px;

              .el-icon {
                margin-right: 4px;
              }
            }
          }
        }

        .exercise-actions {
          margin-left: 20px;
        }
      }
    }
  }

  .exercise-dialog {
    .exercise-header {
      display: flex;
      align-items: center;
      margin-bottom: 24px;

      .progress {
        flex: 1;
        margin-right: 24px;
      }

      .timer {
        display: flex;
        align-items: center;
        font-size: 18px;
        color: #1f2937;

        .el-icon {
          margin-right: 8px;
          color: #1890ff;
        }
      }
    }

    .questions-container {
      max-height: 50vh;
      overflow-y: auto;
      padding-right: 10px;
      margin-bottom: 24px;

      .question-content {
        margin-bottom: 24px;
        padding-bottom: 20px;
        border-bottom: 1px dashed #e5e7eb;

        &:last-child {
          margin-bottom: 0;
          padding-bottom: 0;
          border-bottom: none;
        }

        h3 {
          margin: 0 0 16px;
          color: #1f2937;
        }

        .question-text {
          font-size: 16px;
          color: #4b5563;
          margin-bottom: 20px;
          white-space: pre-wrap;
        }

        .question-option {
          display: block;
          margin-bottom: 12px;
        }
      }
    }

    .submit-button {
      display: flex;
      justify-content: flex-end;
      margin-top: 16px;
    }
  }

  .report-dialog {
    .score-section {
      display: flex;
      align-items: center;
      margin-bottom: 32px;
      padding: 24px;
      background: #f8fafc;
      border-radius: 8px;

      .score-circle {
        width: 120px;
        height: 120px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        background: #1890ff;
        border-radius: 50%;
        color: white;
        margin-right: 32px;

        h2 {
          margin: 0;
          font-size: 36px;
        }

        p {
          margin: 4px 0 0;
          font-size: 14px;
        }
      }

      .score-stats {
        flex: 1;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 16px;

        .stat-item {
          text-align: center;

          .label {
            display: block;
            color: #6b7280;
            margin-bottom: 4px;
          }

          .value {
            font-size: 24px;
            color: #1f2937;
            font-weight: 500;
          }
        }
      }
    }

    .questions-analysis {
      h3 {
        margin: 0 0 20px;
        color: #1f2937;
      }

      .header-right {
        padding: 0.6em 1.2em;
        border-radius: 8px;
        border: 1px solid transparent;
        font-size: 1em;
        font-weight: 200;
        font-family: inherit;
        cursor: pointer;
        transition: border-color 0.25s;
        display: flex;
        justify-content: flex-end;

        button {
          padding: 1rem;
          font-size: 1.2rem;
          border: none;
          cursor: pointer;
          transition: 0.3s ease;
          width: 20%;
          border-radius: 8px;
          box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
          background-color: #bd0a0a;
          color: white;
        }

        :hover {
          transform: scale(1.05);
          opacity: 0.9;
          box-shadow: 0 6px 15px rgba($color: #000000, $alpha: 0.5);
        }
      }

      .questions-analysis-container {
        max-height: 50vh;
        overflow-y: auto;
        padding-right: 10px;

        .question-item {
          padding: 20px;
          border: 1px solid #e5e7eb;
          border-radius: 8px;
          margin-bottom: 16px;

          &:last-child {
            margin-bottom: 0;
          }

          .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;

            .question-number {
              font-weight: 500;
              color: #1f2937;
            }
          }

          .question-content {
            color: #4b5563;
            margin-bottom: 16px;
          }

          .answer-section {
            margin-bottom: 16px;

            p {
              margin: 8px 0;
            }

            .label {
              color: #6b7280;
              margin-right: 8px;
            }

            .wrong-answer {
              color: #dc2626;
            }

            .correct-answer {
              color: #059669;
            }
          }

          .analysis-section {
            background: #f8fafc;
            padding: 12px;
            border-radius: 4px;

            .label {
              color: #6b7280;
              margin-bottom: 4px;
            }

            .analysis-content {
              color: #1f2937;
              margin: 0;
            }
          }
        }
      }
    }
  }

  .loading-dialog {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    text-align: center;

    .el-spinner {
      margin-bottom: 16px;
    }

    p {
      margin: 0;
      font-size: 16px;
      color: #1f2937;
    }
  }
}
</style>