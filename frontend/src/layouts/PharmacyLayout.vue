<template>
  <div class="flex h-screen bg-background">
    <!-- Sidebar -->
    <aside class="w-60 bg-gradient-to-b from-orange-600 to-orange-700 text-white shadow-lg flex flex-col">
      <div class="p-6 border-b border-orange-500">
        <h1 class="text-2xl font-bold">MedSync</h1>
        <p class="text-sm text-orange-100">Pharmacy Portal</p>
      </div>
      
      <nav class="mt-6 flex-1 overflow-auto">
        <router-link
          v-for="item in navItems"
          :key="item.path"
          :to="item.path"
          class="flex items-center px-6 py-3 hover:bg-orange-600 transition-colors"
          :class="{ 'bg-orange-600 border-l-4 border-amber-400': isActive(item.path) }"
        >
          <component :is="item.icon" class="w-5 h-5 mr-3" />
          {{ item.label }}
        </router-link>
      </nav>

      <div class="p-6">
        <button @click="logout" class="w-full btn-outline text-white border-white hover:bg-orange-600">
          Logout
        </button>
      </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 overflow-auto">
      <header class="bg-white shadow-sm border-b border-gray-200 px-8 py-4 flex justify-between items-center">
        <h2 class="text-2xl font-bold text-foreground">{{ pageTitle }}</h2>
        <div class="flex items-center gap-4">
          <button class="p-2 hover:bg-gray-100 rounded-lg">
            <Bell class="w-6 h-6 text-gray-600" />
          </button>
          <div class="w-10 h-10 bg-warning rounded-full"></div>
        </div>
      </header>

      <div class="p-8">
        <router-view />
      </div>
    </main>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { Bell, Home, ListChecks, Package, Truck } from 'lucide-vue-next'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const navItems = [
  { label: 'Dashboard', path: '/pharmacy/dashboard', icon: Home },
  { label: 'Prescription Queue', path: '/pharmacy/prescriptions', icon: ListChecks },
  { label: 'Inventory', path: '/pharmacy/inventory', icon: Package },
  { label: 'Deliveries', path: '/pharmacy/deliveries', icon: Truck }
]

const pageTitle = computed(() => {
  const item = navItems.find(i => i.path === route.path)
  return item?.label || 'Dashboard'
})

const isActive = (path) => route.path === path

const logout = () => {
  authStore.logout()
  router.push('/login')
}
</script>
