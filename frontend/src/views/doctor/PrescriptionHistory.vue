<template>
  <div class="space-y-6">
    <div>
      <h1 class="text-3xl font-bold">Prescription History</h1>
      <p class="text-gray-600 mt-2">View all prescriptions you've created</p>
    </div>

    <!-- Filters -->
    <div class="card flex gap-4">
      <input type="date" class="input-field" />
      <input type="date" class="input-field" />
      <select class="input-field">
        <option>All Status</option>
        <option>Pending</option>
        <option>Filled</option>
        <option>Delivered</option>
      </select>
      <button class="btn-primary">Filter</button>
    </div>

    <!-- Prescriptions Table -->
    <div class="card overflow-x-auto">
      <table class="w-full">
        <thead>
          <tr class="border-b border-gray-200">
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Date</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Patient</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Medications</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Status</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Pharmacy</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in 6" :key="i" class="border-b border-gray-100 hover:bg-gray-50">
            <td class="py-4 px-4 text-sm">2025-01-{{ 20 - i }}</td>
            <td class="py-4 px-4">
              <p class="font-semibold text-sm">Patient {{ i }}</p>
            </td>
            <td class="py-4 px-4 text-sm">{{ 2 + i }} medications</td>
            <td class="py-4 px-4">
              <span class="px-3 py-1 rounded-full text-xs font-semibold" :class="i % 2 === 0 ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'">
                {{ i % 2 === 0 ? 'Filled' : 'Pending' }}
              </span>
            </td>
            <td class="py-4 px-4 text-sm">{{ i % 2 === 0 ? 'Central Pharmacy' : 'Metro Pharmacy' }}</td>
            <td class="py-4 px-4">
              <button class="text-primary hover:underline text-sm font-semibold">View</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
</script>
