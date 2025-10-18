<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <div>
        <h1 class="text-3xl font-bold">My Orders</h1>
        <p class="text-gray-600 mt-2">Track your medication orders</p>
      </div>
      <router-link to="/patient/prescriptions" class="btn-primary">Order Medications</router-link>
    </div>

    <!-- Filter Tabs -->
    <div class="card flex gap-2 border-b border-gray-200 p-0">
      <button
        v-for="tab in ['All', 'Pending', 'In Transit', 'Delivered']"
        :key="tab"
        @click="activeTab = tab"
        class="flex-1 py-4 px-6 font-semibold text-center transition border-b-2"
        :class="activeTab === tab ? 'border-primary text-primary' : 'border-transparent text-gray-600 hover:text-foreground'"
      >
        {{ tab }}
      </button>
    </div>

    <!-- Orders List -->
    <div class="space-y-4">
      <div v-for="i in 3" :key="i" class="card">
        <div class="flex justify-between items-start mb-4">
          <div>
            <p class="font-semibold text-lg">Order #ORD-{{ String(5000 + i).padStart(5, '0') }}</p>
            <p class="text-sm text-gray-600">{{ ['Pending', 'In Transit', 'Delivered'][i - 1] }}</p>
          </div>
          <span class="text-sm font-semibold text-gray-600">₹{{ 1200 + i * 300 }}</span>
        </div>

        <!-- Order Status -->
        <div class="mb-6">
          <div class="flex justify-between mb-2">
            <span class="text-xs font-semibold" :class="i >= 1 ? 'text-green-600' : 'text-gray-400'">Confirmed</span>
            <span class="text-xs font-semibold" :class="i >= 2 ? 'text-green-600' : 'text-gray-400'">Packed</span>
            <span class="text-xs font-semibold" :class="i >= 3 ? 'text-green-600' : 'text-gray-400'">In Transit</span>
            <span class="text-xs font-semibold" :class="i >= 4 ? 'text-green-600' : 'text-gray-400'">Delivered</span>
          </div>
          <div class="w-full h-2 bg-gray-200 rounded-full overflow-hidden">
            <div class="h-full bg-green-500" :style="{ width: (i * 25) + '%' }"></div>
          </div>
        </div>

        <div class="grid md:grid-cols-3 gap-4 mb-4 p-4 bg-gray-50 rounded-lg">
          <div>
            <p class="text-xs text-gray-600">Order Date</p>
            <p class="font-semibold">2025-01-{{ 18 - i }}</p>
          </div>
          <div>
            <p class="text-xs text-gray-600">Pharmacy</p>
            <p class="font-semibold">Central Pharmacy</p>
          </div>
          <div>
            <p class="text-xs text-gray-600">Est. Delivery</p>
            <p class="font-semibold">2025-01-{{ 22 - i }}</p>
          </div>
        </div>

        <div class="flex gap-2">
          <button class="flex-1 btn-outline">Track Delivery</button>
          <button class="flex-1 btn-outline">View Details</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const activeTab = ref('All')
</script>
