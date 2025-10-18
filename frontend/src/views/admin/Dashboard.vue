<template>
  <div class="space-y-8">
    <!-- Header -->
    <div>
      <h1 class="text-4xl font-bold text-foreground">Admin Dashboard</h1>
      <p class="text-gray-600 mt-2">System overview and management</p>
    </div>

    <!-- Statistics Cards -->
    <div class="grid md:grid-cols-4 gap-6">
      <StatCard
        title="Total Patients"
        :value="stats.totalPatients"
        :change="12"
        icon="Users"
        color="blue"
      />
      <StatCard
        title="Active Hospitals"
        :value="stats.totalHospitals"
        :change="5"
        icon="Building2"
        color="green"
      />
      <StatCard
        title="Registered Pharmacies"
        :value="stats.totalPharmacies"
        :change="8"
        icon="ShoppingBag"
        color="orange"
      />
      <StatCard
        title="Prescriptions Today"
        :value="stats.prescriptionsToday"
        :change="23"
        icon="FileText"
        color="purple"
      />
    </div>

    <!-- Charts Row -->
    <div class="grid md:grid-cols-3 gap-6">
      <!-- Prescription Trends -->
      <div class="md:col-span-2 card">
        <h3 class="text-lg font-semibold mb-4">Prescription Trends</h3>
        <div class="h-64 flex items-end justify-around gap-2">
          <div v-for="(value, day) in chartData" :key="day" class="flex flex-col items-center flex-1">
            <div
              class="w-full bg-gradient-to-t from-primary to-blue-400 rounded-t transition-all hover:opacity-80"
              :style="{ height: (value / 100) * 200 + 'px' }"
            ></div>
            <p class="text-xs text-gray-600 mt-2">{{ day }}</p>
          </div>
        </div>
      </div>

      <!-- Resource Alerts -->
      <div class="card">
        <h3 class="text-lg font-semibold mb-4">Resource Alerts</h3>
        <div class="space-y-3">
          <div v-for="alert in resourceAlerts" :key="alert.id" class="p-3 bg-red-50 rounded-lg border border-red-200">
            <div class="flex items-start gap-3">
              <AlertCircle class="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
              <div>
                <p class="font-semibold text-sm text-red-900">{{ alert.hospital }}</p>
                <p class="text-xs text-red-700">{{ alert.message }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- User Management Table -->
    <div class="card">
      <div class="flex justify-between items-center mb-6">
        <h3 class="text-lg font-semibold">Recent Users</h3>
        <div class="flex gap-2">
          <button
            v-for="filter in ['All', 'Doctors', 'Patients', 'Pharmacy']"
            :key="filter"
            @click="activeFilter = filter"
            class="px-3 py-1 rounded-lg text-sm transition"
            :class="activeFilter === filter ? 'bg-primary text-white' : 'bg-gray-100 text-gray-700 hover:bg-gray-200'"
          >
            {{ filter }}
          </button>
        </div>
      </div>

      <div class="overflow-x-auto">
        <table class="w-full">
          <thead>
            <tr class="border-b border-gray-200">
              <th class="text-left py-3 px-4 font-semibold text-gray-700">User</th>
              <th class="text-left py-3 px-4 font-semibold text-gray-700">Role</th>
              <th class="text-left py-3 px-4 font-semibold text-gray-700">Hospital/Pharmacy</th>
              <th class="text-left py-3 px-4 font-semibold text-gray-700">Status</th>
              <th class="text-left py-3 px-4 font-semibold text-gray-700">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(user, idx) in filteredUsers" :key="idx" class="border-b border-gray-100 hover:bg-gray-50 transition">
              <td class="py-4 px-4">
                <div class="flex items-center gap-3">
                  <div class="w-10 h-10 rounded-full bg-gradient-to-br from-primary to-secondary"></div>
                  <div>
                    <p class="font-semibold text-sm">{{ user.name }}</p>
                    <p class="text-xs text-gray-600">{{ user.email }}</p>
                  </div>
                </div>
              </td>
              <td class="py-4 px-4">
                <span
                  class="px-3 py-1 rounded-full text-xs font-semibold"
                  :class="getRoleBadgeClass(user.role)"
                >
                  {{ user.role }}
                </span>
              </td>
              <td class="py-4 px-4 text-sm text-gray-600">{{ user.organization }}</td>
              <td class="py-4 px-4">
                <label class="flex items-center gap-2 cursor-pointer">
                  <input
                    type="checkbox"
                    :checked="user.active"
                    class="w-4 h-4 rounded border-gray-300"
                  />
                  <span class="text-sm" :class="user.active ? 'text-green-600' : 'text-gray-600'">
                    {{ user.active ? 'Active' : 'Inactive' }}
                  </span>
                </label>
              </td>
              <td class="py-4 px-4">
                <div class="flex gap-2">
                  <button class="p-1 hover:bg-gray-200 rounded transition">
                    <Edit2 class="w-4 h-4 text-gray-600" />
                  </button>
                  <button class="p-1 hover:bg-red-100 rounded transition">
                    <Trash2 class="w-4 h-4 text-red-600" />
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="flex justify-between items-center mt-6 pt-4 border-t border-gray-200">
        <p class="text-sm text-gray-600">Showing 1 to 10 of {{ filteredUsers.length }} users</p>
        <div class="flex gap-2">
          <button class="px-3 py-1 border border-gray-300 rounded-lg hover:bg-gray-50 transition text-sm">Previous</button>
          <button class="px-3 py-1 border border-gray-300 rounded-lg hover:bg-gray-50 transition text-sm">Next</button>
        </div>
      </div>
    </div>

    <!-- Bottom Stats Row -->
    <div class="grid md:grid-cols-3 gap-6">
      <!-- Hospital Activity -->
      <div class="card">
        <h3 class="text-lg font-semibold mb-4">Hospital Activity</h3>
        <div class="space-y-3">
          <div v-for="hospital in hospitalStats" :key="hospital.id" class="flex items-center justify-between">
            <div>
              <p class="font-semibold text-sm">{{ hospital.name }}</p>
              <p class="text-xs text-gray-600">{{ hospital.patients }} patients</p>
            </div>
            <div class="w-24 h-2 bg-gray-200 rounded-full overflow-hidden">
              <div class="h-full bg-primary" :style="{ width: hospital.activity + '%' }"></div>
            </div>
          </div>
        </div>
      </div>

      <!-- Pharmacy Performance -->
      <div class="card">
        <h3 class="text-lg font-semibold mb-4">Pharmacy Performance</h3>
        <div class="space-y-3">
          <div v-for="pharmacy in pharmacyStats" :key="pharmacy.id" class="flex items-center justify-between">
            <div>
              <p class="font-semibold text-sm">{{ pharmacy.name }}</p>
              <p class="text-xs text-gray-600">{{ pharmacy.orders }} orders</p>
            </div>
            <span class="text-sm font-semibold text-green-600">{{ pharmacy.rating }}★</span>
          </div>
        </div>
      </div>

      <!-- System Health -->
      <div class="card">
        <h3 class="text-lg font-semibold mb-4">System Health</h3>
        <div class="space-y-4">
          <div>
            <div class="flex justify-between mb-2">
              <p class="text-sm font-semibold">Server Status</p>
              <span class="text-xs text-green-600 font-semibold">Healthy</span>
            </div>
            <div class="w-full h-2 bg-gray-200 rounded-full overflow-hidden">
              <div class="h-full bg-green-500" style="width: 99%"></div>
            </div>
          </div>
          <div>
            <div class="flex justify-between mb-2">
              <p class="text-sm font-semibold">Database</p>
              <span class="text-xs text-green-600 font-semibold">Optimal</span>
            </div>
            <div class="w-full h-2 bg-gray-200 rounded-full overflow-hidden">
              <div class="h-full bg-green-500" style="width: 95%"></div>
            </div>
          </div>
          <div>
            <div class="flex justify-between mb-2">
              <p class="text-sm font-semibold">API Response</p>
              <span class="text-xs text-green-600 font-semibold">Fast</span>
            </div>
            <div class="w-full h-2 bg-gray-200 rounded-full overflow-hidden">
              <div class="h-full bg-green-500" style="width: 98%"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { Users, Building2, ShoppingBag, FileText, AlertCircle, Edit2, Trash2 } from 'lucide-vue-next'
import StatCard from '@/components/admin/StatCard.vue'

const activeFilter = ref('All')

const stats = ref({
  totalPatients: 10234,
  totalHospitals: 52,
  totalPharmacies: 198,
  prescriptionsToday: 1247
})

const chartData = ref({
  'Mon': 65,
  'Tue': 78,
  'Wed': 72,
  'Thu': 85,
  'Fri': 92,
  'Sat': 68,
  'Sun': 55
})

const resourceAlerts = ref([
  { id: 1, hospital: 'City Hospital', message: 'Low stock: Paracetamol (50 units)' },
  { id: 2, hospital: 'Central Clinic', message: 'Critical: Insulin (10 units)' },
  { id: 3, hospital: 'Metro Pharmacy', message: 'Expiry alert: Antibiotics (5 days)' }
])

const users = ref([
  { name: 'Dr. Sarah Johnson', email: 'sarah@hospital.com', role: 'doctor', organization: 'City Hospital', active: true },
  { name: 'John Patient', email: 'john@patient.com', role: 'patient', organization: '-', active: true },
  { name: 'Pharmacy Admin', email: 'admin@pharmacy.com', role: 'pharmacy', organization: 'Central Pharmacy', active: true },
  { name: 'Dr. Mike Chen', email: 'mike@hospital.com', role: 'doctor', organization: 'Metro Hospital', active: false },
  { name: 'Jane Doe', email: 'jane@patient.com', role: 'patient', organization: '-', active: true },
  { name: 'Admin User', email: 'admin@medsync.com', role: 'admin', organization: 'System', active: true },
  { name: 'Dr. Lisa Brown', email: 'lisa@hospital.com', role: 'doctor', organization: 'Central Clinic', active: true },
  { name: 'Pharmacy Manager', email: 'manager@pharmacy.com', role: 'pharmacy', organization: 'Metro Pharmacy', active: true },
])

const hospitalStats = ref([
  { id: 1, name: 'City Hospital', patients: 2450, activity: 85 },
  { id: 2, name: 'Metro Hospital', patients: 1890, activity: 72 },
  { id: 3, name: 'Central Clinic', patients: 1240, activity: 65 }
])

const pharmacyStats = ref([
  { id: 1, name: 'Central Pharmacy', orders: 342, rating: 4.8 },
  { id: 2, name: 'Metro Pharmacy', orders: 298, rating: 4.6 },
  { id: 3, name: 'City Pharmacy', orders: 215, rating: 4.9 }
])

const filteredUsers = computed(() => {
  if (activeFilter.value === 'All') return users.value
  return users.value.filter(u => u.role === activeFilter.value.toLowerCase().slice(0, -1))
})

const getRoleBadgeClass = (role) => {
  const classes = {
    doctor: 'bg-blue-100 text-blue-700',
    patient: 'bg-green-100 text-green-700',
    pharmacy: 'bg-orange-100 text-orange-700',
    admin: 'bg-red-100 text-red-700'
  }
  return classes[role] || 'bg-gray-100 text-gray-700'
}
</script>
