<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <div>
        <h1 class="text-3xl font-bold">My Patients</h1>
        <p class="text-gray-600 mt-2">Manage your patient list</p>
      </div>
      <button class="btn-primary">Add New Patient</button>
    </div>

    <!-- Search and Filter -->
    <div class="card flex gap-4">
      <input
        type="text"
        placeholder="Search patients..."
        class="input-field flex-1"
      />
      <select class="input-field w-40">
        <option>All Patients</option>
        <option>Today's Appointments</option>
        <option>Recent Visits</option>
      </select>
    </div>

    <!-- Patients Table -->
    <div class="card overflow-x-auto">
      <table class="w-full">
        <thead>
          <tr class="border-b border-gray-200">
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Patient</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Age</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Last Visit</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Total Visits</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Status</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in 8" :key="i" class="border-b border-gray-100 hover:bg-gray-50">
            <td class="py-4 px-4">
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-gradient-to-br from-blue-400 to-blue-600"></div>
                <div>
                  <p class="font-semibold">Patient {{ i }}</p>
                  <p class="text-xs text-gray-600">patient{{ i }}@email.com</p>
                </div>
              </div>
            </td>
            <td class="py-4 px-4 text-sm">{{ 25 + i * 3 }} years</td>
            <td class="py-4 px-4 text-sm text-gray-600">{{ i }} days ago</td>
            <td class="py-4 px-4 text-sm">{{ 5 + i }}</td>
            <td class="py-4 px-4">
              <span class="px-3 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-700">Active</span>
            </td>
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
