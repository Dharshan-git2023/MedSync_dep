<template>
  <div class="space-y-6">
    <div>
      <h1 class="text-3xl font-bold">My Prescriptions</h1>
      <p class="text-gray-600 mt-2">View and manage your prescriptions</p>
    </div>

    <!-- Filter Tabs -->
    <div class="card flex gap-2 border-b border-gray-200 p-0">
      <button
        v-for="tab in ['All', 'Active', 'Pending', 'Delivered']"
        :key="tab"
        @click="activeTab = tab"
        class="flex-1 py-4 px-6 font-semibold text-center transition border-b-2"
        :class="activeTab === tab ? 'border-primary text-primary' : 'border-transparent text-gray-600 hover:text-foreground'"
      >
        {{ tab }}
      </button>
    </div>

    <!-- Prescriptions List -->
    <div class="space-y-4">
      <div v-for="i in 4" :key="i" class="card">
        <div class="flex justify-between items-start mb-4">
          <div>
            <p class="font-semibold text-lg">Prescription #RX-{{ String(1000 + i).padStart(5, '0') }}</p>
            <p class="text-sm text-gray-600">Issued by Dr. Sarah Johnson • City Hospital</p>
          </div>
          <span class="px-3 py-1 rounded-full text-xs font-semibold" :class="i % 2 === 0 ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'">
            {{ i % 2 === 0 ? 'Delivered' : 'Pending' }}
          </span>
        </div>

        <div class="mb-4">
          <p class="text-sm font-semibold mb-2">Medications:</p>
          <div class="space-y-2">
            <div v-for="j in 2" :key="j" class="flex items-center gap-2 text-sm">
              <Pill class="w-4 h-4 text-green-600" />
              <span>Medicine {{ j }} - {{ 10 * j }}mg • Twice daily • 30 days</span>
            </div>
          </div>
        </div>

        <div class="grid md:grid-cols-3 gap-4 mb-4 p-4 bg-gray-50 rounded-lg">
          <div>
            <p class="text-xs text-gray-600">Issued Date</p>
            <p class="font-semibold">2025-01-{{ 20 - i }}</p>
          </div>
          <div>
            <p class="text-xs text-gray-600">Pharmacy</p>
            <p class="font-semibold">Central Pharmacy</p>
          </div>
          <div>
            <p class="text-xs text-gray-600">Total Cost</p>
            <p class="font-semibold">₹{{ 500 + i * 100 }}</p>
          </div>
        </div>

        <div class="flex gap-2">
          <button class="flex-1 btn-primary">Order Now</button>
          <button class="flex-1 btn-outline">View Details</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { Pill } from 'lucide-vue-next'

const activeTab = ref('All')
</script>
