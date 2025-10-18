<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'

const authStore = useAuthStore()

onMounted(async () => {
  try {
    if (authStore.isAuthenticated) {
      await authStore.getCurrentUser()
    }
  } catch (error) {
    authStore.logout()
  }
})
</script>

<style scoped>
#app {
  min-height: 100vh;
}
</style>
