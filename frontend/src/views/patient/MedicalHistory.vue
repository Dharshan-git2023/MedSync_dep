<template>
  <div class="space-y-6">
    <div>
      <h1 class="text-3xl font-bold">My Medical History</h1>
      <p class="text-gray-600 mt-2">Complete record of your medical visits and treatments</p>
    </div>

    <!-- Filter -->
    <div class="card flex gap-4">
      <input type="date" class="input-field" />
      <input type="date" class="input-field" />
      <select class="input-field">
        <option>All Types</option>
        <option>Regular Checkup</option>
        <option>Follow-up</option>
        <option>Emergency</option>
      </select>
      <button class="btn-primary">Filter</button>
    </div>

    <!-- Medical Records Timeline -->
    <div class="space-y-4">
      <div v-for="i in 5" :key="i" class="card">
        <div class="flex gap-4">
          <div class="flex flex-col items-center">
            <div class="w-4 h-4 rounded-full bg-blue-500"></div>
            <div v-if="i < 5" class="w-1 h-16 bg-gray-200 mt-2"></div>
          </div>
          <div class="flex-1">
            <div class="flex justify-between items-start mb-2">
              <div>
                <p class="font-semibold text-lg">Visit {{ i }}</p>
                <p class="text-sm text-gray-600">City Hospital • Dr. Sarah Johnson</p>
              </div>
              <span class="px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-700">Regular</span>
            </div>
            <p class="text-sm text-gray-600 mb-3">2025-01-{{ 20 - i }}</p>
            <div class="grid md:grid-cols-2 gap-4 mb-4">
              <div>
                <p class="text-xs text-gray-600">Diagnosis</p>
                <p class="font-semibold">Hypertension</p>
              </div>
              <div>
                <p class="text-xs text-gray-600">Medications</p>
                <p class="font-semibold">Lisinopril 10mg</p>
              </div>
            </div>
            <p class="text-sm text-gray-600 mb-4">Blood pressure elevated, prescribed medication. Follow-up in 2 weeks.</p>
            <button class="text-primary text-sm font-semibold hover:underline">Download Report</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
</script>
