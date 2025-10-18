<template>
  <!-- Updated to match design spec: Orange primary color, warm light gray background, professional pharmacy aesthetic -->
  <div class="min-h-screen bg-gradient-to-br from-white via-orange-50 to-orange-100">
    <!-- Top Header -->
    <div class="bg-white border-b border-gray-200 sticky top-0 z-40 shadow-sm">
      <div class="max-w-7xl mx-auto px-6 py-4">
        <div class="flex justify-between items-center mb-4">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-gradient-to-br from-orange-500 to-red-500 rounded-lg flex items-center justify-center shadow-md">
              <Package class="w-6 h-6 text-white" />
            </div>
            <div>
              <h1 class="text-2xl font-heading font-bold text-gray-900">{{ pharmacyName }}</h1>
              <p class="text-sm text-gray-600">Prescription & Inventory Management</p>
            </div>
          </div>
          <div class="flex items-center gap-4">
            <div class="relative">
              <input type="text" placeholder="Search prescriptions..." class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 w-64 transition-all" />
              <Search class="w-5 h-5 text-gray-400 absolute left-3 top-2.5" />
            </div>
            <div class="bg-orange-100 text-orange-700 px-3 py-1 rounded-full text-sm font-semibold">
              3 new prescriptions
            </div>
            <Bell class="w-5 h-5 text-gray-600 cursor-pointer hover:text-gray-900 transition-colors" />
            <div class="w-10 h-10 bg-gradient-to-br from-orange-400 to-red-400 rounded-full flex items-center justify-center text-white font-semibold cursor-pointer hover:shadow-md transition-shadow">
              P
            </div>
          </div>
        </div>

        <!-- Filter Tabs -->
        <!-- Updated tab styling with orange accent per design spec -->
        <div class="flex gap-2">
          <button v-for="tab in filterTabs" :key="tab" @click="activeTab = tab" :class="[
            'px-4 py-2 rounded-lg font-medium transition-all duration-200',
            activeTab === tab 
              ? 'bg-orange-500 text-white shadow-md hover:bg-orange-600' 
              : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
          ]">
            {{ tab }}
            <span v-if="tab === 'New'" class="ml-2 bg-red-500 text-white text-xs px-2 py-0.5 rounded-full">3</span>
          </button>
        </div>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-6 py-8 space-y-8">
      <!-- Statistics Cards -->
      <!-- Updated stat cards with proper colors and shadows per design spec -->
      <div class="grid md:grid-cols-4 gap-6">
        <div class="bg-white rounded-xl shadow-sm p-6 border-l-4 border-orange-500 hover:shadow-lg transition-all duration-300">
          <div class="flex justify-between items-start">
            <div>
              <p class="text-gray-600 text-sm font-medium">Pending Prescriptions</p>
              <p class="text-4xl font-heading font-bold text-gray-900 mt-2">{{ stats.pending }}</p>
              <p class="text-sm text-orange-600 mt-2 font-semibold">Awaiting processing</p>
            </div>
            <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center">
              <Clock class="w-6 h-6 text-orange-600" />
            </div>
          </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm p-6 border-l-4 border-green-500 hover:shadow-lg transition-all duration-300">
          <div class="flex justify-between items-start">
            <div>
              <p class="text-gray-600 text-sm font-medium">Ready for Pickup</p>
              <p class="text-4xl font-heading font-bold text-gray-900 mt-2">{{ stats.ready }}</p>
              <p class="text-sm text-green-600 mt-2 font-semibold">Available now</p>
            </div>
            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <CheckCircle class="w-6 h-6 text-green-600" />
            </div>
          </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm p-6 border-l-4 border-blue-500 hover:shadow-lg transition-all duration-300">
          <div class="flex justify-between items-start">
            <div>
              <p class="text-gray-600 text-sm font-medium">Out for Delivery</p>
              <p class="text-4xl font-heading font-bold text-gray-900 mt-2">{{ stats.delivery }}</p>
              <p class="text-sm text-blue-600 mt-2 font-semibold">In transit</p>
            </div>
            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
              <Truck class="w-6 h-6 text-blue-600" />
            </div>
          </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm p-6 border-l-4 border-red-500 hover:shadow-lg transition-all duration-300">
          <div class="flex justify-between items-start">
            <div>
              <p class="text-gray-600 text-sm font-medium">Low Stock Items</p>
              <p class="text-4xl font-heading font-bold text-gray-900 mt-2">{{ stats.lowStock }}</p>
              <p class="text-sm text-red-600 mt-2 font-semibold">Require reorder</p>
            </div>
            <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center">
              <AlertCircle class="w-6 h-6 text-red-600" />
            </div>
          </div>
        </div>
      </div>

      <!-- Main Content Grid -->
      <div class="grid md:grid-cols-3 gap-6">
        <!-- Prescription Queue (2 columns) -->
        <!-- Updated card styling with proper shadows and borders per design spec -->
        <div class="md:col-span-2 bg-white rounded-xl shadow-sm p-8 border border-gray-100">
          <div class="flex justify-between items-center mb-6">
            <h3 class="text-xl font-heading font-bold text-gray-900">Prescription Queue</h3>
            <button class="text-orange-600 text-sm font-semibold hover:text-orange-700 transition-colors">View All →</button>
          </div>
          <div class="space-y-4">
            <div v-for="(rx, idx) in prescriptionQueue" :key="idx" class="border border-gray-200 rounded-lg p-5 hover:shadow-md hover:border-orange-300 transition-all duration-300 cursor-pointer">
              <div class="flex justify-between items-start mb-3">
                <div>
                  <p class="font-heading font-bold text-gray-900 text-lg">{{ rx.id }}</p>
                  <p class="text-sm text-gray-600">{{ rx.patientName }} • {{ rx.medicationCount }} medications</p>
                </div>
                <span :class="[
                  'text-xs px-3 py-1 rounded-full font-semibold',
                  rx.priority === 'High' 
                    ? 'bg-red-100 text-red-700' 
                    : 'bg-yellow-100 text-yellow-700'
                ]">
                  {{ rx.priority }} Priority
                </span>
              </div>
              <div class="flex justify-between items-center">
                <div class="flex gap-4 text-sm text-gray-600">
                  <span>{{ rx.hospital }}</span>
                  <span>Dr. {{ rx.doctor }}</span>
                </div>
                <button class="text-orange-600 font-semibold hover:text-orange-700 flex items-center gap-1 transition-colors">
                  View & Process <ChevronRight class="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Low Stock Alerts -->
        <!-- Updated alert styling with red accent per design spec -->
        <div class="bg-white rounded-xl shadow-sm p-8 border border-gray-100">
          <h3 class="text-xl font-heading font-bold text-gray-900 mb-6">Low Stock Alerts</h3>
          <div class="space-y-4">
            <div v-for="(alert, idx) in lowStockAlerts" :key="idx" class="bg-red-50 border-l-4 border-red-500 rounded-lg p-4 hover:shadow-md transition-shadow duration-300">
              <div class="flex justify-between items-start mb-2">
                <p class="font-heading font-bold text-gray-900">{{ alert.medicine }}</p>
                <span class="text-xs px-2 py-1 rounded-full bg-red-100 text-red-700 font-semibold">
                  {{ alert.currentStock }} units
                </span>
              </div>
              <p class="text-sm text-gray-600 mb-3">Reorder level: {{ alert.reorderLevel }} units</p>
              <button class="text-red-600 text-sm font-semibold hover:text-red-700 flex items-center gap-1 transition-colors">
                Reorder Now <ArrowRight class="w-4 h-4" />
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Inventory & Delivery Management -->
      <div class="grid md:grid-cols-2 gap-6">
        <!-- Inventory Categories -->
        <!-- Updated inventory cards with proper styling per design spec -->
        <div class="bg-white rounded-xl shadow-sm p-8 border border-gray-100">
          <h3 class="text-xl font-heading font-bold text-gray-900 mb-6">Inventory by Category</h3>
          <div class="grid grid-cols-2 gap-4">
            <div v-for="(cat, idx) in inventoryCategories" :key="idx" class="bg-gradient-to-br from-gray-50 to-white border border-gray-200 rounded-lg p-4 hover:shadow-md transition-all duration-300 cursor-pointer">
              <div class="flex items-start justify-between mb-3">
                <div class="w-10 h-10 bg-orange-100 rounded-lg flex items-center justify-center">
                  <Package class="w-5 h-5 text-orange-600" />
                </div>
                <span v-if="cat.lowStock > 0" class="text-xs px-2 py-1 rounded-full bg-red-100 text-red-700 font-semibold">
                  {{ cat.lowStock }} low
                </span>
              </div>
              <p class="font-heading font-semibold text-gray-900 text-sm">{{ cat.name }}</p>
              <p class="text-2xl font-heading font-bold text-gray-900 mt-1">{{ cat.total }}</p>
              <p class="text-xs text-gray-600 mt-1">items in stock</p>
            </div>
          </div>
        </div>

        <!-- Delivery Tracking -->
        <!-- Updated delivery cards with proper styling per design spec -->
        <div class="bg-white rounded-xl shadow-sm p-8 border border-gray-100">
          <h3 class="text-xl font-heading font-bold text-gray-900 mb-6">Delivery Status</h3>
          <div class="space-y-4">
            <div v-for="(delivery, idx) in deliveryStatus" :key="idx" class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-all duration-300">
              <div class="flex justify-between items-start mb-3">
                <div>
                  <p class="font-heading font-bold text-gray-900">{{ delivery.orderId }}</p>
                  <p class="text-sm text-gray-600">{{ delivery.patientName }}</p>
                </div>
                <span :class="[
                  'text-xs px-2 py-1 rounded-full font-semibold',
                  delivery.status === 'Delivered' ? 'bg-green-100 text-green-700' :
                  delivery.status === 'In Transit' ? 'bg-blue-100 text-blue-700' :
                  'bg-yellow-100 text-yellow-700'
                ]">
                  {{ delivery.status }}
                </span>
              </div>
              <p class="text-sm text-gray-600 mb-2">{{ delivery.address }}</p>
              <div class="flex items-center gap-2 text-sm text-gray-600">
                <MapPin class="w-4 h-4" />
                {{ delivery.location }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Hospital Collaboration -->
      <!-- Updated collaboration cards with proper styling per design spec -->
      <div class="bg-white rounded-xl shadow-sm p-8 border border-gray-100">
        <h3 class="text-xl font-heading font-bold text-gray-900 mb-6">Hospital Collaboration</h3>
        <div class="grid md:grid-cols-3 gap-6">
          <div v-for="(hospital, idx) in hospitalCollaborations" :key="idx" class="border border-gray-200 rounded-lg p-6 hover:shadow-md transition-all duration-300">
            <div class="flex items-start justify-between mb-4">
              <div>
                <p class="font-heading font-bold text-gray-900">{{ hospital.name }}</p>
                <p class="text-sm text-gray-600">{{ hospital.location }}</p>
              </div>
              <span :class="[
                'text-xs px-2 py-1 rounded-full font-semibold',
                hospital.status === 'Active' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'
              ]">
                {{ hospital.status }}
              </span>
            </div>
            <div class="space-y-2 text-sm text-gray-600 mb-4">
              <p>Pending requests: <span class="font-heading font-semibold text-gray-900">{{ hospital.pendingRequests }}</span></p>
              <p>Fulfilled orders: <span class="font-heading font-semibold text-gray-900">{{ hospital.fulfilledOrders }}</span></p>
            </div>
            <button class="text-orange-600 text-sm font-semibold hover:text-orange-700 transition-colors">View Details →</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { Package, Search, Bell, Clock, CheckCircle, Truck, AlertCircle, ChevronRight, ArrowRight, MapPin } from 'lucide-vue-next'

const pharmacyName = ref('MedCare Pharmacy')
const activeTab = ref('All')
const filterTabs = ref(['All', 'New', 'In Progress', 'Ready', 'Out for Delivery'])

const stats = ref({
  pending: 12,
  ready: 8,
  delivery: 5,
  lowStock: 3
})

const prescriptionQueue = ref([
  { id: 'RX-1001', patientName: 'John Smith', medicationCount: 3, hospital: 'City Hospital', doctor: 'Sarah Johnson', priority: 'High' },
  { id: 'RX-1002', patientName: 'Jane Doe', medicationCount: 2, hospital: 'Central Clinic', doctor: 'Mike Chen', priority: 'Normal' },
  { id: 'RX-1003', patientName: 'Bob Wilson', medicationCount: 4, hospital: 'Metro Hospital', doctor: 'Lisa Brown', priority: 'Normal' }
])

const lowStockAlerts = ref([
  { medicine: 'Lisinopril 10mg', currentStock: 5, reorderLevel: 50 },
  { medicine: 'Metformin 500mg', currentStock: 8, reorderLevel: 100 },
  { medicine: 'Aspirin 100mg', currentStock: 3, reorderLevel: 30 }
])

const inventoryCategories = ref([
  { name: 'Antibiotics', total: 245, lowStock: 2 },
  { name: 'Pain Relief', total: 189, lowStock: 1 },
  { name: 'Cardiac', total: 156, lowStock: 0 },
  { name: 'Diabetes', total: 203, lowStock: 1 }
])

const deliveryStatus = ref([
  { orderId: 'ORD-5001', patientName: 'John Smith', address: '123 Main St, City', location: 'In transit', status: 'In Transit' },
  { orderId: 'ORD-5002', patientName: 'Jane Doe', address: '456 Oak Ave, Town', location: 'Out for delivery', status: 'In Transit' },
  { orderId: 'ORD-5003', patientName: 'Bob Wilson', address: '789 Pine Rd, Village', location: 'Delivered', status: 'Delivered' }
])

const hospitalCollaborations = ref([
  { name: 'City Hospital', location: 'Downtown', status: 'Active', pendingRequests: 3, fulfilledOrders: 156 },
  { name: 'Central Clinic', location: 'Midtown', status: 'Active', pendingRequests: 1, fulfilledOrders: 89 },
  { name: 'Metro Hospital', location: 'Uptown', status: 'Active', pendingRequests: 2, fulfilledOrders: 203 }
])
</script>
