<script setup lang="ts">
import { ref } from 'vue'
import { Menu as IconMenu, Document, Collection} from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const isCollapse = ref(false)

const handleMenuSelect = (index: string) => {
  switch (index) {
    case '1':
      router.push('/Exercise')
      break
    case '2':
    router.push('/Performance')
      break
  }
}
</script>

<template>
  <el-container class="layout-container">
    <el-aside :width="isCollapse ? '64px' : '200px'" class="aside">
      <div class="logo">
        <img src="/aisai.png" alt="Logo" class="logo-img" />
        <span v-show="!isCollapse">智慧学习平台</span>
      </div>
      <el-menu
        :collapse="isCollapse"
        class="menu"
        default-active="1"
        background-color="#001529"
        text-color="#fff"
        @select="handleMenuSelect"
      >
        <el-menu-item index="1">
          <el-icon><Document /></el-icon>
          <span>在线练习</span>
        </el-menu-item>
        <el-menu-item index="2">
          <el-icon><Collection /></el-icon>
          <span>学习情况</span>
        </el-menu-item>
      </el-menu>
    </el-aside>

    <el-container>
      <el-header class="header">
        <el-button
          type="text"
          class="collapse-btn"
          @click="isCollapse = !isCollapse"
        >
          <el-icon><IconMenu /></el-icon>
        </el-button>
        <div class="header-right">
          <el-dropdown>
            <span class="user-info">
              <el-avatar size="small" />
              学生用户
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item>个人信息</el-dropdown-item>
                <el-dropdown-item @click = "router.push('/')">退出登录 </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </el-header>

      <el-main class="main">
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<style scoped lang="scss">
.layout-container {
  height: 100vh;
  
  .aside {
    background-color: #001529;
    transition: width 0.3s;
    
    .logo {
      height: 60px;
      display: flex;
      align-items: center;
      padding: 0 20px;
      color: white;
      
      .logo-img {
        height: 32px;
        margin-right: 12px;
      }
    }
    
    .menu {
      border-right: none;
    }
  }
  
  .header {
    background-color: white;
    border-bottom: 1px solid #e6e6e6;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 20px;
    
    .collapse-btn {
      font-size: 20px;
    }
    
    .header-right {
      .user-info {
        display: flex;
        align-items: center;
        cursor: pointer;
        
        .el-avatar {
          margin-right: 8px;
        }
      }
    }
  }
  
  .main {
    background-color: #f0f2f5;
    padding: 20px;
  }
}
</style>