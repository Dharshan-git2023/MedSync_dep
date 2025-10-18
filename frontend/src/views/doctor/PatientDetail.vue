<template>
  <div class="space-y-6">
    <div class="flex items-center gap-4">
      <button @click="$router.back()" class="p-2 hover:bg-gray-100 rounded-lg">
        <ChevronLeft class="w-6 h-6" />
      </button>
      <div>
        <h1 class="text-3xl font-bold">Patient Details</h1>
        <p class="text-gray-600 mt-1">Complete medical profile</p>
      </div>
    </div>

    <!-- Patient Info Card -->
    <div class="card">
      <div class="grid md:grid-cols-4 gap-6">
        <div>
          <p class="text-gray-600 text-sm">Full Name</p>
          <p class="text-lg font-semibold mt-1">John Smith</p>
        </div>
        <div>
          <p class="text-gray-600 text-sm">Age & Gender</p>
          <p class="text-lg font-semibold mt-1">45 • Male</p>
        </div>
        <div>
          <p class="text-gray-600 text-sm">Blood Group</p>
          <p class="text-lg font-semibold mt-1">O+</p>
        </div>
        <div>
          <p class="text-gray-600 text-sm">Allergies</p>
          <p class="text-lg font-semibold mt-1">Penicillin</p>
        </div>
      </div>
    </div>

    <!-- Medical Records -->
    <div class="card">
      <h3 class="text-lg font-semibold mb-4">Medical Records</h3>
      <div class="space-y-3">
        <div v-for="i in 3" :key="i" class="p-4 border border-gray-200 rounded-lg">
          <div class="flex justify-between items-start mb-2">
            <p class="font-semibold">Visit {{ i }}</p>
            <span class="text-xs px-2 py-1 rounded-full bg-blue-100 text-blue-700">Regular</span>
          </div>
          <p class="text-sm text-gray-600 mb-2">2025-01-{{ 15 - i }}</p>
          <p class="text-sm">Diagnosis: Hypertension • Prescribed: Lisinopril</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ChevronLeft } from 'lucide-vue-next'
</script>
