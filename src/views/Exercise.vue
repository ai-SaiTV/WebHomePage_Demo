<script setup lang="ts">
import { ref, computed, nextTick } from 'vue'

interface Exercise {
  id: string
  title: string
  subject: string
  difficulty: string
  questionCount: number
  timeLimit: number
  status: 'not_started' | 'in_progress' | 'completed'
  score?: number
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
    title: '分数运算专项练习',
    subject: '数学',
    difficulty: '中等',
    questionCount: 10,
    timeLimit: 30,
    status: 'not_started'
  },
  {
    id: '2',
    title: '几何图形基础练习',
    subject: '数学',
    difficulty: '简单',
    questionCount: 15,
    timeLimit: 45,
    status: 'completed',
    score: 92
  },
  {
    id: '3',
    title: '方程式解法练习',
    subject: '数学',
    difficulty: '较难',
    questionCount: 8,
    timeLimit: 25,
    status: 'in_progress'
  }
])

// 模拟题目数据
const questions = ref<Question[]>([
  {
    id: 1,
    type: 'choice',
    content: '下列分数中，最大的是？',
    options: ['1/2', '2/3', '3/4', '4/5'],
    answer: '4/5',
    analysis: '通过通分或小数转换可以比较分数大小'
  },
  {
    id: 2,
    type: 'fill',
    content: '在□里填上适当的数，使等式成立：3/4 + □ = 1',
    answer: '1/4',
    analysis: '用1减去3/4即可得到答案'
  },
  {
    id: 3,
    type: 'text',
    content: '请解释为什么1/3不能写成有限小数？',
    answer: '因为1÷3的除法过程中余数会循环出现，导致小数位无限循环',
    analysis: '这涉及到分数转小数时的除法特性'
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
  return {
    percentage: (currentQuestionIndex.value + 1) / questions.value.length * 100,
    text: `${currentQuestionIndex.value + 1}/${questions.value.length}`
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
  questions.value.forEach(question => {
    if (userAnswers.value[question.id] === question.answer) {
      correctCount++
    }
  })
  
  const score = Math.round((correctCount / questions.value.length) * 100)
  
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
        <el-input
          v-model="searchKeyword"
          placeholder="搜索练习"
          prefix-icon="Search"
          clearable
        />
      </div>
    </div>

    <!-- 练习统计卡片 -->
    <el-row :gutter="20" class="stat-row">
      <el-col :span="8">
        <el-card class="stat-card">
          <div class="stat-content">
            <el-icon class="stat-icon" color="#1890ff"><Edit /></el-icon>
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
            <el-icon class="stat-icon" color="#52c41a"><CircleCheckFilled /></el-icon>
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
            <el-icon class="stat-icon" color="#722ed1"><Timer /></el-icon>
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
        <div
          v-for="exercise in filteredExercises"
          :key="exercise.id"
          class="exercise-item"
        >
          <div class="exercise-info">
            <h3>{{ exercise.title }}</h3>
            <div class="exercise-tags">
              <el-tag size="small">{{ exercise.subject }}</el-tag>
              <el-tag
                size="small"
                :type="getDifficultyTag(exercise.difficulty)"
              >
                {{ exercise.difficulty }}
              </el-tag>
              <el-tag
                size="small"
                :type="getStatusTag(exercise.status).type"
              >
                {{ getStatusTag(exercise.status).label }}
              </el-tag>
            </div>
            <div class="exercise-details">
              <span>
                <el-icon><Document /></el-icon>
                {{ exercise.questionCount }}题
              </span>
              <span>
                <el-icon><Timer /></el-icon>
                {{ exercise.timeLimit }}分钟
              </span>
              <span v-if="exercise.score !== undefined">
                <el-icon><DataLine /></el-icon>
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
    <el-dialog
      v-model="exerciseDialogVisible"
      :title="selectedExercise?.title"
      width="50%"
      :close-on-click-modal="false"
      :before-close="closeExercise"
    >
      <div class="exercise-dialog">
        <!-- 进度条和计时器 -->
        <div class="exercise-header">
          <el-progress
            :percentage="progress.percentage"
            :format="() => progress.text"
            class="progress"
          />
          <div class="timer">
            <el-icon><Timer /></el-icon>
            {{ formattedTime }}
          </div>
        </div>

        <!-- 题目内容区域（可滚动） -->
        <div class="questions-container" ref="questionsContainer">
          <div v-for="(question, index) in questions" :key="question.id" class="question-content" :id="`question-${question.id}`">
            <h3>第 {{ index + 1 }} 题</h3>
            <p class="question-text">{{ question.content }}</p>

            <!-- 选择题 -->
            <template v-if="question.type === 'choice'">
              <el-radio-group v-model="userAnswers[question.id]" @click="scrollToQuestion(question.id)">
                <el-radio
                  v-for="option in question.options"
                  :key="option"
                  :label="option"
                  class="question-option"
                >
                  {{ option }}
                </el-radio>
              </el-radio-group>
            </template>

            <!-- 填空题 -->
            <template v-else-if="question.type === 'fill'">
              <el-input
                v-model="userAnswers[question.id]"
                placeholder="请输入答案"
                @focus="scrollToQuestion(question.id)"
              />
            </template>

            <!-- 解答题 -->
            <template v-else-if="question.type === 'text'">
              <el-input
                v-model="userAnswers[question.id]"
                type="textarea"
                :rows="4"
                placeholder="请输入答案"
                @focus="scrollToQuestion(question.id)"
              />
            </template>
          </div>
        </div>

        <!-- 提交按钮 -->
        <div class="submit-button">
          <el-button
            type="primary"
            @click="submitAnswer"
          >
            提交
          </el-button>
        </div>
      </div>
    </el-dialog>

    <!-- 报告对话框 -->
    <el-dialog
      v-model="reportDialogVisible"
      title="练习报告"
      width="50%"
    >
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
          <h3>题目分析</h3>
          <div class="questions-analysis-container">
            <div
              v-for="question in questions"
              :key="question.id"
              class="question-item"
            >
              <div class="question-header">
                <span class="question-number">第{{ question.id }}题</span>
                <el-tag
                  :type="userAnswers[question.id] === question.answer ? 'success' : 'danger'"
                  size="small"
                >
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
}
</style>