<template>
  <div class="space-y-6">
    <div>
      <h1 class="text-3xl font-bold">Delivery Tracking</h1>
      <p class="text-gray-600 mt-2">Track medication deliveries</p>
    </div>

    <!-- Kanban Board -->
    <div class="grid md:grid-cols-4 gap-6">
      <div v-for="column in kanbanColumns" :key="column.title" class="bg-gray-50 rounded-lg p-4">
        <h3 class="font-semibold mb-4">{{ column.title }}</h3>
        <div class="space-y-3">
          <div v-for="order in column.orders" :key="order.id" class="bg-white p-4 rounded-lg shadow-sm hover:shadow-md transition">
            <p class="font-semibold text-sm">{{ order.id }}</p>
            <p class="text-xs text-gray-600 mb-2">{{ order.patient }}</p>
            <p class="text-xs text-gray-600">{{ order.address }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const kanbanColumns = ref([
  {
    title: 'Packed',
    orders: [
      { id: 'ORD-5001', patient: 'John Smith', address: '123 Main St' },
      { id: 'ORD-5002', patient: 'Sarah Johnson', address: '456 Oak Ave' }
    ]
  },
  {
    title: 'Out for Delivery',
    orders: [
      { id: 'ORD-5003', patient: 'Michael Chen', address: '789 Pine Rd' },
      { id: 'ORD-5004', patient: 'Jane Doe', address: '321 Elm St' }
    ]
  },
  {
    title: 'Delivered',
    orders: [
      { id: 'ORD-5005', patient: 'Robert Wilson', address: '654 Maple Dr' },
      { id: 'ORD-5006', patient: 'Emily Davis', address: '987 Cedar Ln' }
    ]
  },
  {
    title: 'Issues',
    orders: [
      { id: 'ORD-5007', patient: 'David Brown', address: 'Address not found' }
    ]
  }
])
</script>
