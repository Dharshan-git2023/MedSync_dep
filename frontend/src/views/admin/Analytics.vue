<template>
  <div class="space-y-6">
    <div>
      <h1 class="text-3xl font-bold">System Analytics</h1>
      <p class="text-gray-600 mt-2">View system-wide analytics and statistics</p>
    </div>

    <!-- Date Range Selector -->
    <div class="card flex gap-4">
      <input type="date" class="input-field" />
      <input type="date" class="input-field" />
      <button class="btn-primary">Apply Filter</button>
    </div>

    <!-- Analytics Cards -->
    <div class="grid md:grid-cols-3 gap-6">
      <div class="card">
        <p class="text-gray-600 text-sm">Total Transactions</p>
        <p class="text-4xl font-bold mt-2">₹45.2M</p>
        <p class="text-sm text-green-600 mt-2">↑ 18% from last month</p>
      </div>
      <div class="card">
        <p class="text-gray-600 text-sm">Active Users</p>
        <p class="text-4xl font-bold mt-2">12,450</p>
        <p class="text-sm text-green-600 mt-2">↑ 24% from last month</p>
      </div>
      <div class="card">
        <p class="text-gray-600 text-sm">System Uptime</p>
        <p class="text-4xl font-bold mt-2">99.9%</p>
        <p class="text-sm text-green-600 mt-2">Excellent performance</p>
      </div>
    </div>

    <!-- Detailed Charts -->
    <div class="grid md:grid-cols-2 gap-6">
      <div class="card">
        <h3 class="text-lg font-semibold mb-4">Prescriptions by Month</h3>
        <div class="h-64 flex items-end justify-around gap-2">
          <div v-for="(value, month) in monthlyData" :key="month" class="flex flex-col items-center flex-1">
            <div
              class="w-full bg-gradient-to-t from-primary to-blue-400 rounded-t"
              :style="{ height: (value / 100) * 200 + 'px' }"
            ></div>
            <p class="text-xs text-gray-600 mt-2">{{ month }}</p>
          </div>
        </div>
      </div>

      <div class="card">
        <h3 class="text-lg font-semibold mb-4">User Distribution</h3>
        <div class="space-y-4">
          <div>
            <div class="flex justify-between mb-2">
              <p class="text-sm font-semibold">Patients</p>
              <p class="text-sm text-gray-600">6,200 (50%)</p>
            </div>
            <div class="w-full h-3 bg-gray-200 rounded-full overflow-hidden">
              <div class="h-full bg-green-500" style="width: 50%"></div>
            </div>
          </div>
          <div>
            <div class="flex justify-between mb-2">
              <p class="text-sm font-semibold">Doctors</p>
              <p class="text-sm text-gray-600">2,480 (20%)</p>
            </div>
            <div class="w-full h-3 bg-gray-200 rounded-full overflow-hidden">
              <div class="h-full bg-blue-500" style="width: 20%"></div>
            </div>
          </div>
          <div>
            <div class="flex justify-between mb-2">
              <p class="text-sm font-semibold">Pharmacies</p>
              <p class="text-sm text-gray-600">1,860 (15%)</p>
            </div>
            <div class="w-full h-3 bg-gray-200 rounded-full overflow-hidden">
              <div class="h-full bg-orange-500" style="width: 15%"></div>
            </div>
          </div>
          <div>
            <div class="flex justify-between mb-2">
              <p class="text-sm font-semibold">Admins</p>
              <p class="text-sm text-gray-600">910 (15%)</p>
            </div>
            <div class="w-full h-3 bg-gray-200 rounded-full overflow-hidden">
              <div class="h-full bg-red-500" style="width: 15%"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const monthlyData = ref({
  'Jan': 45,
  'Feb': 52,
  'Mar': 48,
  'Apr': 61,
  'May': 55,
  'Jun': 67,
  'Jul': 72,
  'Aug': 68,
  'Sep': 75,
  'Oct': 82,
  'Nov': 78,
  'Dec': 85
})
</script>
