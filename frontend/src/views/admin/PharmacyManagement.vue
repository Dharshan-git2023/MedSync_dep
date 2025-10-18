<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <div>
        <h1 class="text-3xl font-bold">Pharmacy Management</h1>
        <p class="text-gray-600 mt-2">Manage pharmacy registrations and operations</p>
      </div>
      <button class="btn-primary">Register Pharmacy</button>
    </div>

    <!-- Pharmacies Grid -->
    <div class="grid md:grid-cols-2 gap-6">
      <div v-for="i in 4" :key="i" class="card">
        <div class="flex justify-between items-start mb-4">
          <div>
            <h3 class="text-lg font-semibold">Pharmacy {{ i }}</h3>
            <p class="text-sm text-gray-600">License: PHARM-{{ String(i).padStart(5, '0') }}</p>
          </div>
          <span class="px-3 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-700">Active</span>
        </div>
        <div class="space-y-2 text-sm text-gray-600 mb-4">
          <p>📍 Main Street, District {{ i }}</p>
          <p>📞 +1 (555) 111-{{ String(i).padStart(4, '0') }}</p>
          <p>🚚 Delivery: {{ 5 + i }}km radius</p>
          <p>📦 {{ 200 + i * 100 }} Items in Stock</p>
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
