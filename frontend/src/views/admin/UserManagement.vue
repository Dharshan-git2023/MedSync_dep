<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <div>
        <h1 class="text-3xl font-bold">User Management</h1>
        <p class="text-gray-600 mt-2">Manage all system users and permissions</p>
      </div>
      <button class="btn-primary">Add New User</button>
    </div>

    <!-- Search and Filter -->
    <div class="card flex gap-4">
      <input
        type="text"
        placeholder="Search users..."
        class="input-field flex-1"
      />
      <select class="input-field w-40">
        <option>All Roles</option>
        <option>Doctor</option>
        <option>Patient</option>
        <option>Pharmacy</option>
        <option>Admin</option>
      </select>
      <select class="input-field w-40">
        <option>All Status</option>
        <option>Active</option>
        <option>Inactive</option>
      </select>
    </div>

    <!-- Users Table -->
    <div class="card overflow-x-auto">
      <table class="w-full">
        <thead>
          <tr class="border-b border-gray-200">
            <th class="text-left py-3 px-4 font-semibold text-gray-700">User</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Email</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Role</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Joined</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Status</th>
            <th class="text-left py-3 px-4 font-semibold text-gray-700">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in 5" :key="i" class="border-b border-gray-100 hover:bg-gray-50">
            <td class="py-4 px-4">
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-gradient-to-br from-primary to-secondary"></div>
                <p class="font-semibold">User {{ i }}</p>
              </div>
            </td>
            <td class="py-4 px-4 text-sm text-gray-600">user{{ i }}@example.com</td>
            <td class="py-4 px-4">
              <span class="px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-700">Doctor</span>
            </td>
            <td class="py-4 px-4 text-sm text-gray-600">2025-01-{{ 10 + i }}</td>
            <td class="py-4 px-4">
              <span class="px-3 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-700">Active</span>
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
