<template>
  <div class="card hover:shadow-lg transition-shadow">
    <div class="flex justify-between items-start">
      <div>
        <p class="text-gray-600 text-sm font-medium">{{ title }}</p>
        <p class="text-4xl font-bold text-foreground mt-2">{{ value.toLocaleString() }}</p>
        <p class="text-sm mt-2" :class="change >= 0 ? 'text-green-600' : 'text-red-600'">
          <span>{{ change >= 0 ? '↑' : '↓' }} {{ Math.abs(change) }}%</span>
          <span class="text-gray-600">vs last month</span>
        </p>
      </div>
      <div
        class="w-12 h-12 rounded-lg flex items-center justify-center"
        :class="getColorClass(color)"
      >
        <component :is="icon" class="w-6 h-6 text-white" />
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: String,
  value: Number,
  change: Number,
  icon: String,
  color: String
})

const getColorClass = (color) => {
  const colors = {
    blue: 'bg-blue-500',
    green: 'bg-green-500',
    orange: 'bg-orange-500',
    purple: 'bg-purple-500'
  }
  return colors[color] || 'bg-primary'
}
</script>
