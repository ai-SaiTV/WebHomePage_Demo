<template>
  <el-dialog :visible.sync="show" :title="`${student?.name || ''} - 学生详情`" width="80%">
    <div v-loading="loading">
      <el-row :gutter="20">
        <!-- 基本信息 -->
        <el-col :span="8">
          <el-card class="student-info-card">
            <div class="student-profile">
              <!-- <el-avatar :size="64">{{ student?.name.charAt(0) }}</el-avatar> -->
              <h3>姓名：{{ student?.name }}</h3>
              <p>学科：{{ student?.class }}</p>
              <div class="student-stats">
                <div class="stat-item">
                  <div class="label">本次得分</div>
                  <div class="value">{{ student?.total || 0 }}</div>
                </div>
                <div class="stat-item">
                  <div class="label">平均分</div>
                  <div class="value">{{ student?.average.toFixed(2) || 0 }}</div>
                </div>
                <div class="stat-item">
                  <div class="label">排名</div>
                  <div class="value">{{ student?.rank || '-' }}</div>
                </div>
              </div>
            </div>
          </el-card>
        </el-col>

        <!-- 成绩趋势 -->
        <el-col :span="16">
          <el-card class="trend-card">
            <div ref="performanceChartRef" style="height: 300px;"></div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 个人分析 -->
      <el-row :gutter="20" class="mt-4">
        <h2>学生分析</h2>
        <el-col :span="12">
          <el-card>
            <template #header>
              <div class="card-header">
                <span>优势分析</span>
              </div>
            </template>
            <ul class="analysis-list">
              <p v-if="analysis"><li v-for="(strength, index) in analysis.strengths" :key="index">
                <el-icon class="success-icon">
                  <CircleCheckFilled />
                </el-icon>
                {{ strength }}
              </li></p>
              <p v-else>Analysis data is not available.</p>
            </ul>
          </el-card>
        </el-col>
        <el-col :span="12">
          <el-card>
            <template #header>
              <div class="card-header">
                <span>待提升项</span>
              </div>
            </template>
            <ul class="analysis-list">
              <p v-if="analysis"><li v-for="(weakness, index) in analysis.weaknesses" :key="index">
                <el-icon class="warning-icon">
                  <Warning />
                </el-icon>
                {{ weakness }}
              </li></p>
              <p v-else>Analysis data is not available.</p>
            </ul>
          </el-card>
        </el-col>
      </el-row>

      <!-- 学习建议 -->
      <el-card class="mt-4">
        <template #header>
          <div class="card-header">
            <span>学习建议</span>
          </div>
        </template>
        <ul class="recommendation-list">
          <p v-if="analysis"><li v-for="(rec, index) in analysis.recommendations" :key="index">
            <el-icon><Star /></el-icon>
            {{ rec }}
          </li></p>
          <p v-else>Analysis data is not available.</p>
        </ul>
      </el-card>
    </div>
  </el-dialog>
</template>

<script setup lang="ts">
import { ref, onMounted, watch, PropType } from "vue";
import * as echarts from "echarts";
import { CircleCheckFilled, Warning, Star } from "@element-plus/icons-vue";

interface Student {
  id: string;
  name: string;
  scores: number[];
  total: number;
  average: number;
  rank: number;
  class: string;
}

const props = defineProps({
  show: Boolean,
  student: Object as PropType<Student | null>,
  analysis: Object as PropType<{
    strengths: string[];
    weaknesses: string[];
    recommendations: string[];
  }>,
  loading: Boolean,
});

const emits = defineEmits(['update:show']);

const internalShow = ref(props.show);

watch(() => props.show, (newVal) => {
  internalShow.value = newVal;
});

watch(internalShow, (newVal) => {
  emits('update:show', newVal);
});

const performanceChartRef = ref<HTMLElement>();

onMounted(() => {
  if (performanceChartRef.value && props.student) {
    const chart = echarts.init(performanceChartRef.value);
    chart.setOption({
      title: { text: "成绩趋势" },
      tooltip: { trigger: "axis" },
      xAxis: {
        type: "category",
        data: props.student.scores.map((_, index) => (index + 1).toString()),
      },
      yAxis: { type: "value", min: 0, max: 10 },
      series: [
        {
          name: "成绩",
          type: "line",
          data: props.student.scores.slice(0, 8),
          smooth: true,
          itemStyle: { color: "#1890ff" },
          areaStyle: {
            color: {
              type: "linear",
              x: 0,
              y: 0,
              x2: 0,
              y2: 1,
              colorStops: [
                { offset: 0, color: "rgba(24,144,255,0.3)" },
                { offset: 1, color: "rgba(24,144,255,0.1)" },
              ],
            },
          },
        },
      ],
    });
  }
});

watch(() => props.show, (newVal) => {
  if (!newVal) {
    emits('update:show', false);
  }
});
</script>

<style scoped lang="scss">
.student-info-card {
  .student-profile {
    text-align: center;
    padding: 20px;

    h3 {
      margin: 12px 0 4px;
      color: #1f2937;
    }

    p {
      color: #6b7280;
      margin: 0 0 16px;
    }

    .student-stats {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 12px;
      margin-top: 20px;

      .stat-item {
        text-align: center;
        padding: 8px;
        background: #f8fafc;
        border-radius: 8px;

        .label {
          color: #6b7280;
          font-size: 12px;
        }

        .value {
          color: #1890ff;
          font-size: 18px;
          font-weight: bold;
          margin-top: 4px;
        }
      }
    }
  }
}

.analysis-list {
  list-style: none;
  padding: 0;
  margin: 0;

  li {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    color: #4b5563;

    .el-icon {
      margin-right: 8px;
    }

    .success-icon {
      color: #67c23a;
    }

    .warning-icon {
      color: #e6a23c;
    }
  }
}

.recommendation-list {
  list-style: none;
  padding: 0;
  margin: 0;

  li {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    color: #4b5563;

    .el-icon {
      color: #1890ff;
      margin-right: 8px;
    }
  }
}
</style>