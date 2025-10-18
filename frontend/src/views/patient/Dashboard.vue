<template>
  <!-- Updated to match design spec: Friendly blue primary color, soft gradient background, consumer-friendly aesthetic -->
  <div class="min-h-screen bg-gradient-to-br from-white via-blue-50 to-blue-100">
    <!-- Top Navigation -->
    <div class="bg-white border-b border-gray-200 sticky top-0 z-40 shadow-sm">
      <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <div class="flex items-center gap-2">
          <div class="w-8 h-8 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-lg flex items-center justify-center">
            <Heart class="w-5 h-5 text-white" />
          </div>
          <span class="font-heading font-bold text-lg text-gray-900">MedSync Patient</span>
        </div>
        <div class="flex items-center gap-4">
          <Bell class="w-5 h-5 text-gray-600 cursor-pointer hover:text-gray-900 transition-colors" />
          <div class="w-10 h-10 bg-gradient-to-br from-blue-400 to-cyan-400 rounded-full flex items-center justify-center text-white font-semibold cursor-pointer hover:shadow-md transition-shadow">
            {{ patientName.charAt(0) }}
          </div>
        </div>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-6 py-8 space-y-8">
      <!-- Welcome Banner -->
      <!-- Updated gradient to match design spec: blue to cyan, with friendly tone -->
      <div class="bg-gradient-to-r from-blue-500 via-cyan-500 to-teal-500 rounded-2xl p-8 text-white shadow-lg hover:shadow-xl transition-shadow">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-4xl font-heading font-bold mb-2">Welcome back, {{ patientName }}!</h1>
            <p class="text-blue-100 text-lg">Your health is our priority</p>
          </div>
          <div class="text-right bg-white bg-opacity-20 backdrop-blur-md rounded-lg p-4 border border-white/30">
            <p class="text-blue-100 text-sm">Last Visit</p>
            <p class="text-2xl font-bold">{{ lastVisit }}</p>
          </div>
        </div>
      </div>

      <!-- Quick Actions Row -->
      <!-- Updated card styling with proper shadows, rounded corners, and hover effects per design -->
      <div class="grid md:grid-cols-3 gap-6">
        <router-link to="/patient/medical-history" class="group">
          <div class="bg-white rounded-xl p-6 shadow-sm hover:shadow-lg transition-all duration-300 cursor-pointer border-l-4 border-blue-500 hover:border-blue-600">
            <div class="w-14 h-14 bg-gradient-to-br from-blue-100 to-blue-50 rounded-lg flex items-center justify-center mb-4 group-hover:scale-110 transition-transform duration-300">
              <FileText class="w-7 h-7 text-blue-600" />
            </div>
            <h3 class="text-lg font-heading font-bold text-gray-900 mb-1">View My Records</h3>
            <p class="text-gray-600 text-sm">Access your complete medical history</p>
          </div>
        </router-link>

        <router-link to="/patient/prescriptions" class="group">
          <div class="bg-white rounded-xl p-6 shadow-sm hover:shadow-lg transition-all duration-300 cursor-pointer border-l-4 border-green-500 hover:border-green-600">
            <div class="w-14 h-14 bg-gradient-to-br from-green-100 to-green-50 rounded-lg flex items-center justify-center mb-4 group-hover:scale-110 transition-transform duration-300">
              <Pill class="w-7 h-7 text-green-600" />
            </div>
            <h3 class="text-lg font-heading font-bold text-gray-900 mb-1">Active Prescriptions</h3>
            <p class="text-gray-600 text-sm">{{ activePrescriptions }} active prescriptions</p>
          </div>
        </router-link>

        <router-link to="/patient/orders" class="group">
          <div class="bg-white rounded-xl p-6 shadow-sm hover:shadow-lg transition-all duration-300 cursor-pointer border-l-4 border-orange-500 hover:border-orange-600">
            <div class="w-14 h-14 bg-gradient-to-br from-orange-100 to-orange-50 rounded-lg flex items-center justify-center mb-4 group-hover:scale-110 transition-transform duration-300">
              <ShoppingBag class="w-7 h-7 text-orange-600" />
            </div>
            <h3 class="text-lg font-heading font-bold text-gray-900 mb-1">Order Medications</h3>
            <p class="text-gray-600 text-sm">Order from verified pharmacies</p>
          </div>
        </router-link>
      </div>

      <!-- Health Journey Timeline -->
      <!-- Updated timeline styling with proper colors and spacing per design spec -->
      <div class="bg-white rounded-xl shadow-sm p-8 border border-gray-100">
        <h2 class="text-2xl font-heading font-bold text-gray-900 mb-8">My Health Journey</h2>
        <div class="space-y-6">
          <div v-for="(visit, idx) in healthTimeline" :key="idx" class="flex gap-6">
            <!-- Timeline -->
            <div class="flex flex-col items-center">
              <div class="w-5 h-5 rounded-full border-4 border-white shadow-md" :class="getTimelineColor(visit.type)"></div>
              <div v-if="idx < healthTimeline.length - 1" class="w-1 h-24 bg-gradient-to-b from-gray-300 to-gray-100 mt-3"></div>
            </div>

            <!-- Visit Card -->
            <div class="flex-1 pb-4">
              <div class="bg-gradient-to-br from-gray-50 to-white border border-gray-200 rounded-lg p-6 hover:shadow-md transition-shadow duration-300">
                <div class="flex justify-between items-start mb-3">
                  <div>
                    <p class="font-heading font-bold text-gray-900 text-lg">{{ visit.hospital }}</p>
                    <p class="text-sm text-gray-600">Dr. {{ visit.doctor }}</p>
                  </div>
                  <span class="text-xs px-3 py-1 rounded-full font-semibold" :class="getVisitBadgeClass(visit.type)">
                    {{ visit.type }}
                  </span>
                </div>
                <p class="text-sm text-gray-500 mb-3">{{ formatDate(visit.date) }}</p>
                <p class="text-gray-700 mb-4">{{ visit.diagnosis }}</p>
                <button class="text-blue-600 text-sm font-semibold hover:text-blue-700 flex items-center gap-1 transition-colors">
                  Download Report <Download class="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Two Column Section -->
      <div class="grid md:grid-cols-2 gap-6">
        <!-- Active Prescriptions -->
        <!-- Updated with green accent color per design spec for patient-friendly aesthetic -->
        <div class="bg-white rounded-xl shadow-sm p-8 border border-gray-100">
          <h3 class="text-xl font-heading font-bold text-gray-900 mb-6">Active Prescriptions</h3>
          <div class="space-y-4">
            <div v-for="med in activeMeds" :key="med.id" class="bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200 rounded-lg p-5 hover:shadow-md transition-shadow duration-300">
              <div class="flex justify-between items-start mb-3">
                <div>
                  <p class="font-heading font-bold text-gray-900">{{ med.name }}</p>
                  <p class="text-sm text-gray-600">{{ med.dosage }} • {{ med.frequency }}</p>
                </div>
                <span class="text-xs px-2 py-1 rounded-full bg-green-100 text-green-700 font-semibold">
                  {{ med.daysRemaining }}d left
                </span>
              </div>
              <div class="w-full h-2 bg-gray-200 rounded-full overflow-hidden mb-3">
                <div class="h-full bg-gradient-to-r from-green-400 to-emerald-500" :style="{ width: med.progress + '%' }"></div>
              </div>
              <div class="flex justify-between items-center">
                <p class="text-xs text-gray-600">{{ med.progress }}% completed</p>
                <span v-if="med.refillNeeded" class="text-xs px-2 py-1 rounded-full bg-yellow-100 text-yellow-700 font-semibold">
                  Refill Soon
                </span>
              </div>
            </div>
          </div>
          <router-link to="/patient/prescriptions" class="text-blue-600 text-sm font-semibold hover:text-blue-700 mt-6 inline-flex items-center gap-1 transition-colors">
            View All Prescriptions <ChevronRight class="w-4 h-4" />
          </router-link>
        </div>

        <!-- Upcoming Appointments -->
        <!-- Updated with blue accent color per design spec -->
        <div class="bg-white rounded-xl shadow-sm p-8 border border-gray-100">
          <h3 class="text-xl font-heading font-bold text-gray-900 mb-6">Upcoming Appointments</h3>
          <div class="space-y-4">
            <div v-for="apt in upcomingAppointments" :key="apt.id" class="bg-gradient-to-r from-blue-50 to-cyan-50 border border-blue-200 rounded-lg p-5 hover:shadow-md transition-shadow duration-300">
              <div class="flex justify-between items-start mb-3">
                <div>
                  <p class="font-heading font-bold text-gray-900">{{ apt.doctor }}</p>
                  <p class="text-sm text-gray-600">{{ apt.hospital }}</p>
                </div>
                <Calendar class="w-5 h-5 text-blue-600" />
              </div>
              <p class="text-sm text-gray-600 mb-3">{{ formatDate(apt.date) }} at {{ apt.time }}</p>
              <button class="text-blue-600 text-sm font-semibold hover:text-blue-700 transition-colors">Reschedule</button>
            </div>
          </div>
        </div>
      </div>

      <!-- AI Health Assistant -->
      <!-- Updated with purple accent color per design spec for AI assistant -->
      <div class="bg-gradient-to-br from-purple-50 to-pink-50 border-2 border-purple-200 rounded-xl p-8 hover:shadow-lg transition-shadow duration-300">
        <div class="flex items-start gap-6">
          <div class="w-16 h-16 bg-gradient-to-br from-purple-400 to-pink-400 rounded-xl flex items-center justify-center flex-shrink-0 shadow-lg hover:shadow-xl transition-shadow">
            <MessageCircle class="w-8 h-8 text-white" />
          </div>
          <div class="flex-1">
            <h3 class="text-xl font-heading font-bold text-gray-900 mb-2">AI Health Assistant</h3>
            <p class="text-gray-600 mb-5">Get instant answers about your health and medications</p>
            <div class="flex flex-wrap gap-3">
              <button class="px-4 py-2 bg-white rounded-full text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors border border-gray-300 shadow-sm hover:shadow-md">
                When should I take my medicine?
              </button>
              <button class="px-4 py-2 bg-white rounded-full text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors border border-gray-300 shadow-sm hover:shadow-md">
                What's my prescription status?
              </button>
              <button class="px-4 py-2 bg-white rounded-full text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors border border-gray-300 shadow-sm hover:shadow-md">
                Show my last visit details
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { FileText, Pill, ShoppingBag, Bell, MessageCircle, Heart, Download, ChevronRight, Calendar } from 'lucide-vue-next'

const patientName = ref('John Smith')
const lastVisit = ref('2 days ago')
const activePrescriptions = ref(3)

const healthTimeline = ref([
  {
    id: 1,
    hospital: 'City Hospital',
    doctor: 'Sarah Johnson',
    date: '2025-01-15',
    diagnosis: 'Hypertension - Blood pressure elevated, prescribed Lisinopril for daily management',
    type: 'Regular'
  },
  {
    id: 2,
    hospital: 'Central Clinic',
    doctor: 'Mike Chen',
    date: '2025-01-08',
    diagnosis: 'Diabetes Type 2 - Blood sugar levels improving with medication adjustments',
    type: 'Follow-up'
  },
  {
    id: 3,
    hospital: 'Metro Hospital',
    doctor: 'Lisa Brown',
    date: '2024-12-28',
    diagnosis: 'Annual Checkup - All vitals normal, continue current medications',
    type: 'Regular'
  }
])

const activeMeds = ref([
  { id: 1, name: 'Lisinopril', dosage: '10mg', frequency: 'Once daily', daysRemaining: 15, progress: 50, refillNeeded: true },
  { id: 2, name: 'Metformin', dosage: '500mg', frequency: 'Twice daily', daysRemaining: 20, progress: 33, refillNeeded: false },
  { id: 3, name: 'Aspirin', dosage: '100mg', frequency: 'Once daily', daysRemaining: 25, progress: 17, refillNeeded: false }
])

const upcomingAppointments = ref([
  { id: 1, doctor: 'Dr. Sarah Johnson', hospital: 'City Hospital', date: '2025-02-05', time: '10:00 AM' },
  { id: 2, doctor: 'Dr. Mike Chen', hospital: 'Central Clinic', date: '2025-02-12', time: '2:30 PM' }
])

const getTimelineColor = (type) => {
  const colors = {
    'Regular': 'bg-blue-500',
    'Follow-up': 'bg-green-500',
    'Emergency': 'bg-red-500'
  }
  return colors[type] || 'bg-gray-500'
}

const getVisitBadgeClass = (type) => {
  const classes = {
    'Regular': 'bg-blue-100 text-blue-700',
    'Follow-up': 'bg-green-100 text-green-700',
    'Emergency': 'bg-red-100 text-red-700'
  }
  return classes[type] || 'bg-gray-100 text-gray-700'
}

const formatDate = (dateStr) => {
  const date = new Date(dateStr)
  return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}
</script>
