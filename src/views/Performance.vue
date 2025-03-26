<script setup lang="ts">
import { ref, onMounted } from 'vue'
import * as echarts from 'echarts'

interface SubjectPerformance {
  subject: string
  score: number
  rank: number
  exercises: number
  accuracy: number
}

const performanceData = ref<SubjectPerformance[]>([
  {
    subject: '数学',
    score: 92,
    rank: 5,
    exercises: 120,
    accuracy: 85
  },
  {
    subject: '语文',
    score: 88,
    rank: 8,
    exercises: 95,
    accuracy: 82
  },
  {
    subject: '英语',
    score: 95,
    rank: 3,
    exercises: 150,
    accuracy: 90
  }
])

const recentExercises = ref([
  { date: '2024-03-01', score: 85 },
  { date: '2024-03-05', score: 88 },
  { date: '2024-03-10', score: 92 },
  { date: '2024-03-15', score: 90 },
  { date: '2024-03-20', score: 95 }
])

const weakPoints = ref([
  '方程式解法',
  '几何证明',
  '函数图像'
])

const strengths = ref([
  '基础运算',
  '数据分析',
  '逻辑推理'
])

const trendChartRef = ref<HTMLElement | null>(null)
const subjectChartRef = ref<HTMLElement | null>(null)

onMounted(() => {
  if (trendChartRef.value) {
    initTrendChart(trendChartRef.value)
  }
  if (subjectChartRef.value) {
    initSubjectChart(subjectChartRef.value)
  }
})

const initTrendChart = (el: HTMLElement) => {
  const chart = echarts.init(el)
  chart.setOption({
    title: {
      text: '近期练习成绩趋势'
    },
    tooltip: {
      trigger: 'axis'
    },
    xAxis: {
      type: 'category',
      data: recentExercises.value.map(item => item.date)
    },
    yAxis: {
      type: 'value',
      min: 60
    },
    series: [{
      name: '成绩',
      type: 'line',
      data: recentExercises.value.map(item => item.score),
      smooth: true,
      itemStyle: {
        color: '#1890ff'
      },
      areaStyle: {
        color: {
          type: 'linear',
          x: 0,
          y: 0,
          x2: 0,
          y2: 1,
          colorStops: [{
            offset: 0,
            color: 'rgba(24,144,255,0.3)'
          }, {
            offset: 1,
            color: 'rgba(24,144,255,0.1)'
          }]
        }
      }
    }]
  })
}

const initSubjectChart = (el: HTMLElement) => {
  const chart = echarts.init(el)
  chart.setOption({
    title: {
      text: '各科目表现'
    },
    radar: {
      indicator: [
        { name: '数学', max: 100 },
        { name: '语文', max: 100 },
        { name: '英语', max: 100 }
      ]
    },
    series: [{
      type: 'radar',
      data: [{
        value: performanceData.value.map(item => item.score),
        name: '得分',
        itemStyle: {
          color: '#1890ff'
        },
        areaStyle: {
          color: 'rgba(24,144,255,0.2)'
        }
      }]
    }]
  })
}
</script>

<template>
  <div class="performance-container">
    <div class="page-header">
      <div class="header-left">
        <h2>学习情况</h2>
        <p class="subtitle">查看学习进度和成绩分析</p>
      </div>
      <div class="header-right">
        <button> 错题生成</button>
      </div>
    </div>

    <!-- 概览卡片 -->
    <el-row :gutter="20" class="stat-row">
      <el-col :span="8" v-for="subject in performanceData" :key="subject.subject">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="subject-info">
              <h3>{{ subject.subject }}</h3>
              <div class="score">{{ subject.score }}分</div>
            </div>
            <div class="detail-list">
              <div class="detail-item">
                <span class="label">班级排名</span>
                <span class="value">第{{ subject.rank }}名</span>
              </div>
              <div class="detail-item">
                <span class="label">练习题数</span>
                <span class="value">{{ subject.exercises }}题</span>
              </div>
              <div class="detail-item">
                <span class="label">正确率</span>
                <span class="value">{{ subject.accuracy }}%</span>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 图表分析 -->
    <el-row :gutter="20" class="chart-row">
      <el-col :span="16">
        <el-card class="chart-card">
          <div ref="trendChartRef" style="height: 400px;"></div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="chart-card">
          <div ref="subjectChartRef" style="height: 400px;"></div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 学习分析 -->
    <el-row :gutter="20" class="analysis-row">
      <el-col :span="12">
        <el-card class="analysis-card">
          <template #header>
            <div class="card-header">
              <h3>需要提升的知识点</h3>
            </div>
          </template>
          <div class="point-list">
            <div v-for="(point, index) in weakPoints" :key="index" class="point-item">
              <el-icon class="warning-icon">
                <Warning />
              </el-icon>
              <span>{{ point }}</span>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="analysis-card">
          <template #header>
            <div class="card-header">
              <h3>已掌握的知识点</h3>
            </div>
          </template>
          <div class="point-list">
            <div v-for="(point, index) in strengths" :key="index" class="point-item">
              <el-icon class="success-icon">
                <CircleCheckFilled />
              </el-icon>
              <span>{{ point }}</span>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped lang="scss">
.performance-container {
  .page-header {
    margin-bottom: 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    h2 {
      margin: 0;
      font-size: 24px;
      color: #1f2937;
    }



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
      padding: 0.6em 1.2em;
      border-radius: 8px;
      border: 1px solid transparent;
      font-size: 1em;
      font-weight: 500;
      font-family: inherit;
      cursor: pointer;
      transition: border-color 0.25s;
      button {
        padding: 1rem;
        font-size: 1.2rem;
        border: none;
        cursor: pointer;
        transition: 0.3s ease;
        width: 100%;
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
  }

  .stat-row {
    margin-bottom: 24px;

    .stat-card {
      .stat-content {
        padding: 20px;

        .subject-info {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 16px;

          h3 {
            margin: 0;
            font-size: 18px;
            color: #1f2937;
          }

          .score {
            font-size: 24px;
            font-weight: bold;
            color: #1890ff;
          }
        }

        .detail-list {
          .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 14px;

            .label {
              color: #6b7280;
            }

            .value {
              color: #1f2937;
              font-weight: 500;
            }
          }
        }
      }
    }
  }

  .chart-row {
    margin-bottom: 24px;

    .chart-card {
      height: 100%;
    }
  }

  .analysis-row {
    .analysis-card {
      .card-header {
        h3 {
          margin: 0;
          font-size: 16px;
          color: #1f2937;
        }
      }

      .point-list {
        .point-item {
          display: flex;
          align-items: center;
          padding: 12px;
          border-bottom: 1px solid #e5e7eb;

          &:last-child {
            border-bottom: none;
          }

          .warning-icon {
            color: #e6a23c;
            margin-right: 8px;
          }

          .success-icon {
            color: #67c23a;
            margin-right: 8px;
          }

          span {
            color: #4b5563;
          }
        }
      }
    }
  }
}
</style>