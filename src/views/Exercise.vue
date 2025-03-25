<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
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

const activeTab = ref('all')
const searchKeyword = ref('')

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
  // 实现开始练习的逻辑
  console.log('开始练习:', exercise.title)
  router.push(`/Exercise/${exercise.id}`)
}

const continueExercise = (exercise: Exercise) => {
  // 实现继续练习的逻辑
  console.log('继续练习:', exercise.title)
  router.push(`/Exercise/${exercise.id}`)
  
}

const viewReport = (exercise: Exercise) => {
  // 实现查看报告的逻辑
  console.log('查看报告:', exercise.title)
  router.push(`/Exercise/${exercise.id}`)
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
}
</style>