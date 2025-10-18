<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <div>
        <h1 class="text-3xl font-bold">Hospital Management</h1>
        <p class="text-gray-600 mt-2">Manage hospital networks and collaborations</p>
      </div>
      <button class="btn-primary">Register Hospital</button>
    </div>

    <!-- Hospitals Grid -->
    <div class="grid md:grid-cols-2 gap-6">
      <div v-for="i in 4" :key="i" class="card">
        <div class="flex justify-between items-start mb-4">
          <div>
            <h3 class="text-lg font-semibold">Hospital {{ i }}</h3>
            <p class="text-sm text-gray-600">License: HOS-{{ String(i).padStart(5, '0') }}</p>
          </div>
          <span class="px-3 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-700">Active</span>
        </div>
        <div class="space-y-2 text-sm text-gray-600 mb-4">
          <p>📍 City Center, Downtown</p>
          <p>📞 +1 (555) 000-{{ String(i).padStart(4, '0') }}</p>
          <p>👥 {{ 100 + i * 50 }} Doctors</p>
        </div>
        <div class="flex gap-2 pt-4 border-t border-gray-200">
          <button class="flex-1 btn-outline text-sm">Edit</button>
          <button class="flex-1 btn-outline text-sm">View Details</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
</script>
