<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <div>
        <h1 class="text-3xl font-bold">Inventory Management</h1>
        <p class="text-gray-600 mt-2">Manage your medication inventory</p>
      </div>
      <button class="btn-primary">Add New Item</button>
    </div>

    <!-- Search and Filter -->
    <div class="card flex gap-4">
      <input type="text" placeholder="Search medications..." class="input-field flex-1" />
      <select class="input-field w-40">
        <option>All Categories</option>
        <option>Antibiotics</option>
        <option>Pain Relief</option>
        <option>Cardiac</option>
      </select>
    </div>

    <!-- Inventory Table -->
    <div class="card overflow-x-auto">
      <table class="w-full">
        <thead>
          <tr class="border-b border-gray-200">
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Medicine</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Stock</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Unit Price</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Expiry Date</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Status</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in 6" :key="i" class="border-b border-gray-100 hover:bg-gray-50">
            <td class="py-4 px-4 font-semibold">Medicine {{ i }}</td>
            <td class="py-4 px-4">
              <p class="font-semibold">{{ 100 - i * 10 }} units</p>
            </td>
            <td class="py-4 px-4">₹{{ 50 + i * 10 }}</td>
            <td class="py-4 px-4 text-sm">2025-{{ String(6 + i).padStart(2, '0') }}-15</td>
            <td class="py-4 px-4">
              <span class="px-3 py-1 rounded-full text-xs font-semibold" :class="i < 3 ? 'bg-red-100 text-red-700' : 'bg-green-100 text-green-700'">
                {{ i < 3 ? 'Low Stock' : 'In Stock' }}
              </span>
            </td>
            <td class="py-4 px-4">
              <button class="text-primary hover:underline text-sm font-semibold">Edit</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
</script>
