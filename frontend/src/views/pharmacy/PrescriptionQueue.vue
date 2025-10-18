<template>
  <div class="space-y-6">
    <div>
      <h1 class="text-3xl font-bold">Prescription Queue</h1>
      <p class="text-gray-600 mt-2">Process pending prescriptions</p>
    </div>

    <!-- Filter Tabs -->
    <div class="card flex gap-2 border-b border-gray-200 p-0">
      <button
        v-for="tab in ['New', 'In Progress', 'Ready', 'Out for Delivery']"
        :key="tab"
        @click="activeTab = tab"
        class="flex-1 py-4 px-6 font-semibold text-center transition border-b-2"
        :class="activeTab === tab ? 'border-primary text-primary' : 'border-transparent text-gray-600 hover:text-foreground'"
      >
        {{ tab }}
      </button>
    </div>

    <!-- Prescriptions Table -->
    <div class="card overflow-x-auto">
      <table class="w-full">
        <thead>
          <tr class="border-b border-gray-200">
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Prescription ID</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Patient</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Medications</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Status</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in 5" :key="i" class="border-b border-gray-100 hover:bg-gray-50">
            <td class="py-4 px-4 font-semibold">RX-{{ String(1000 + i).padStart(5, '0') }}</td>
            <td class="py-4 px-4">
              <p class="font-semibold text-sm">Patient {{ i }}</p>
              <p class="text-xs text-gray-600">patient{{ i }}@email.com</p>
            </td>
            <td class="py-4 px-4 text-sm">{{ 2 + i }} medications</td>
            <td class="py-4 px-4">
              <span class="px-3 py-1 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-700">Pending</span>
            </td>
            <td class="py-4 px-4">
              <button class="text-primary hover:underline text-sm font-semibold">Process</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const activeTab = ref('New')
</script>
