<template>
  <div class="space-y-8">
    <!-- Header -->
    <div>
      <h1 class="text-4xl font-bold text-foreground">Doctor Dashboard</h1>
      <p class="text-gray-600 mt-2">Manage your patients and prescriptions</p>
    </div>

    <!-- Quick Stats -->
    <div class="grid md:grid-cols-4 gap-6">
      <div class="card">
        <p class="text-gray-600 text-sm">My Patients</p>
        <p class="text-4xl font-bold mt-2">{{ stats.totalPatients }}</p>
        <p class="text-sm text-blue-600 mt-2">Active today: {{ stats.activeTodayPatients }}</p>
      </div>
      <div class="card">
        <p class="text-gray-600 text-sm">Today's Appointments</p>
        <p class="text-4xl font-bold mt-2">{{ stats.todayAppointments }}</p>
        <p class="text-sm text-green-600 mt-2">{{ stats.completedAppointments }} completed</p>
      </div>
      <div class="card">
        <p class="text-gray-600 text-sm">Pending Prescriptions</p>
        <p class="text-4xl font-bold mt-2">{{ stats.pendingPrescriptions }}</p>
        <p class="text-sm text-orange-600 mt-2">Awaiting verification</p>
      </div>
      <div class="card">
        <p class="text-gray-600 text-sm">Patient Alerts</p>
        <p class="text-4xl font-bold mt-2">{{ stats.alerts }}</p>
        <p class="text-sm text-red-600 mt-2">Require attention</p>
      </div>
    </div>

    <!-- Main Content: Two Column Layout -->
    <div class="grid md:grid-cols-3 gap-6">
      <!-- Left: Patient List -->
      <div class="md:col-span-1 card p-0 flex flex-col">
        <div class="p-6 border-b border-gray-200">
          <h3 class="text-lg font-semibold mb-4">My Patients</h3>
          <div class="relative">
            <Search class="absolute left-3 top-3 w-5 h-5 text-gray-400" />
            <input
              v-model="searchQuery"
              type="text"
              placeholder="Search patients..."
              class="input-field pl-10"
            />
          </div>
          <select v-model="patientFilter" class="input-field mt-3">
            <option value="">All Patients</option>
            <option value="today">Today's Appointments</option>
            <option value="recent">Recent Visits</option>
          </select>
        </div>

        <div class="flex-1 overflow-y-auto">
          <div
            v-for="patient in filteredPatients"
            :key="patient.id"
            @click="selectPatient(patient)"
            class="p-4 border-b border-gray-100 hover:bg-blue-50 cursor-pointer transition"
            :class="{ 'bg-blue-50 border-l-4 border-primary': selectedPatient?.id === patient.id }"
          >
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 rounded-full bg-gradient-to-br from-blue-400 to-blue-600"></div>
              <div class="flex-1 min-w-0">
                <p class="font-semibold text-sm truncate">{{ patient.name }}</p>
                <p class="text-xs text-gray-600">{{ patient.age }} years • {{ patient.lastVisit }}</p>
              </div>
              <AlertCircle v-if="patient.alert" class="w-4 h-4 text-red-600 flex-shrink-0" />
            </div>
          </div>
        </div>

        <div class="p-4 border-t border-gray-200">
          <button class="w-full btn-primary">+ Add New Patient</button>
        </div>
      </div>

      <!-- Right: Patient Details (Tabbed) -->
      <div class="md:col-span-2">
        <div v-if="selectedPatient" class="space-y-6">
          <!-- Patient Header -->
          <div class="card">
            <div class="flex justify-between items-start mb-4">
              <div>
                <h2 class="text-2xl font-bold">{{ selectedPatient.name }}</h2>
                <p class="text-gray-600">{{ selectedPatient.age }} years • {{ selectedPatient.gender }}</p>
              </div>
              <div class="flex gap-2">
                <span class="px-3 py-1 rounded-full text-xs font-semibold bg-red-100 text-red-700">
                  Allergies: Penicillin
                </span>
                <span class="px-3 py-1 rounded-full text-xs font-semibold bg-orange-100 text-orange-700">
                  Blood: O+
                </span>
              </div>
            </div>
            <div class="grid md:grid-cols-4 gap-4 text-sm">
              <div>
                <p class="text-gray-600">Phone</p>
                <p class="font-semibold">{{ selectedPatient.phone }}</p>
              </div>
              <div>
                <p class="text-gray-600">Email</p>
                <p class="font-semibold">{{ selectedPatient.email }}</p>
              </div>
              <div>
                <p class="text-gray-600">Last Visit</p>
                <p class="font-semibold">{{ selectedPatient.lastVisit }}</p>
              </div>
              <div>
                <p class="text-gray-600">Total Visits</p>
                <p class="font-semibold">{{ selectedPatient.totalVisits }}</p>
              </div>
            </div>
          </div>

          <!-- Tabs -->
          <div class="card p-0">
            <div class="flex border-b border-gray-200">
              <button
                v-for="tab in tabs"
                :key="tab"
                @click="activeTab = tab"
                class="flex-1 py-4 px-6 font-semibold text-center transition border-b-2"
                :class="activeTab === tab ? 'border-primary text-primary' : 'border-transparent text-gray-600 hover:text-foreground'"
              >
                {{ tab }}
              </button>
            </div>

            <div class="p-6">
              <!-- Medical Overview Tab -->
              <div v-if="activeTab === 'Medical Overview'" class="space-y-6">
                <div>
                  <h4 class="font-semibold mb-3">Medical History Timeline</h4>
                  <div class="space-y-3">
                    <div v-for="record in selectedPatient.medicalHistory" :key="record.id" class="p-4 border border-gray-200 rounded-lg hover:shadow-md transition">
                      <div class="flex justify-between items-start mb-2">
                        <p class="font-semibold">{{ record.diagnosis }}</p>
                        <span class="text-xs px-2 py-1 rounded-full" :class="getVisitTypeClass(record.type)">
                          {{ record.type }}
                        </span>
                      </div>
                      <p class="text-sm text-gray-600 mb-2">{{ record.date }}</p>
                      <p class="text-sm">{{ record.notes }}</p>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Create Prescription Tab -->
              <div v-if="activeTab === 'Create Prescription'" class="space-y-4">
                <div>
                  <label class="block text-sm font-semibold mb-2">Symptoms</label>
                  <textarea
                    v-model="prescriptionForm.symptoms"
                    class="input-field"
                    rows="3"
                    placeholder="Describe patient symptoms..."
                  ></textarea>
                </div>

                <div>
                  <label class="block text-sm font-semibold mb-2">Diagnosis</label>
                  <input
                    v-model="prescriptionForm.diagnosis"
                    type="text"
                    class="input-field"
                    placeholder="Enter diagnosis..."
                  />
                </div>

                <div class="grid md:grid-cols-2 gap-4">
                  <div>
                    <label class="block text-sm font-semibold mb-2">Blood Pressure</label>
                    <input v-model="prescriptionForm.bp" type="text" class="input-field" placeholder="120/80" />
                  </div>
                  <div>
                    <label class="block text-sm font-semibold mb-2">Temperature</label>
                    <input v-model="prescriptionForm.temp" type="text" class="input-field" placeholder="98.6°F" />
                  </div>
                </div>

                <div>
                  <div class="flex justify-between items-center mb-3">
                    <label class="block text-sm font-semibold">Medications</label>
                    <button @click="addMedication" class="text-primary text-sm font-semibold hover:underline">
                      + Add Medicine
                    </button>
                  </div>

                  <div class="space-y-3">
                    <div v-for="(med, idx) in prescriptionForm.medications" :key="idx" class="p-3 bg-blue-50 rounded-lg flex justify-between items-start">
                      <div class="flex-1">
                        <p class="font-semibold text-sm">{{ med.name }}</p>
                        <p class="text-xs text-gray-600">{{ med.dosage }} • {{ med.frequency }} • {{ med.days }} days</p>
                      </div>
                      <button @click="removeMedication(idx)" class="text-red-600 hover:text-red-700">
                        <X class="w-4 h-4" />
                      </button>
                    </div>
                  </div>
                </div>

                <div>
                  <label class="block text-sm font-semibold mb-2">Special Instructions</label>
                  <textarea
                    v-model="prescriptionForm.instructions"
                    class="input-field"
                    rows="2"
                    placeholder="Any special instructions..."
                  ></textarea>
                </div>

                <div class="flex gap-3 pt-4">
                  <button class="flex-1 btn-primary">Generate E-Prescription</button>
                  <button class="flex-1 btn-outline">Save Draft</button>
                </div>
              </div>

              <!-- Prescription History Tab -->
              <div v-if="activeTab === 'Prescription History'" class="space-y-3">
                <div v-for="rx in selectedPatient.prescriptions" :key="rx.id" class="p-4 border border-gray-200 rounded-lg">
                  <div class="flex justify-between items-start mb-2">
                    <p class="font-semibold">{{ rx.medications.length }} medications</p>
                    <span class="text-xs px-2 py-1 rounded-full" :class="getStatusClass(rx.status)">
                      {{ rx.status }}
                    </span>
                  </div>
                  <p class="text-sm text-gray-600">{{ rx.date }} • {{ rx.pharmacy }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div v-else class="card text-center py-12">
          <Users class="w-16 h-16 text-gray-300 mx-auto mb-4" />
          <p class="text-gray-600">Select a patient to view details</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { Search, AlertCircle, X, Users } from 'lucide-vue-next'

const searchQuery = ref('')
const patientFilter = ref('')
const activeTab = ref('Medical Overview')
const selectedPatient = ref(null)

const tabs = ['Medical Overview', 'Create Prescription', 'Prescription History']

const stats = ref({
  totalPatients: 48,
  activeTodayPatients: 12,
  todayAppointments: 8,
  completedAppointments: 5,
  pendingPrescriptions: 3,
  alerts: 2
})

const patients = ref([
  {
    id: 1,
    name: 'John Smith',
    age: 45,
    gender: 'Male',
    phone: '+1 (555) 123-4567',
    email: 'john@email.com',
    lastVisit: '2 days ago',
    totalVisits: 12,
    alert: true,
    medicalHistory: [
      { id: 1, diagnosis: 'Hypertension', type: 'Regular', date: '2025-01-15', notes: 'BP elevated, prescribed medication' },
      { id: 2, diagnosis: 'Diabetes Type 2', type: 'Follow-up', date: '2025-01-08', notes: 'Blood sugar levels improving' }
    ],
    prescriptions: [
      { id: 1, medications: ['Lisinopril', 'Metformin'], date: '2025-01-15', pharmacy: 'Central Pharmacy', status: 'Filled' },
      { id: 2, medications: ['Aspirin'], date: '2025-01-08', pharmacy: 'Metro Pharmacy', status: 'Delivered' }
    ]
  },
  {
    id: 2,
    name: 'Sarah Johnson',
    age: 32,
    gender: 'Female',
    phone: '+1 (555) 234-5678',
    email: 'sarah@email.com',
    lastVisit: '1 week ago',
    totalVisits: 5,
    alert: false,
    medicalHistory: [
      { id: 1, diagnosis: 'Common Cold', type: 'Regular', date: '2025-01-10', notes: 'Viral infection, rest recommended' }
    ],
    prescriptions: [
      { id: 1, medications: ['Cough Syrup', 'Paracetamol'], date: '2025-01-10', pharmacy: 'City Pharmacy', status: 'Pending' }
    ]
  },
  {
    id: 3,
    name: 'Michael Chen',
    age: 58,
    gender: 'Male',
    phone: '+1 (555) 345-6789',
    email: 'michael@email.com',
    lastVisit: '3 days ago',
    totalVisits: 24,
    alert: false,
    medicalHistory: [
      { id: 1, diagnosis: 'Cardiac Checkup', type: 'Regular', date: '2025-01-14', notes: 'Heart rate normal, EKG clear' }
    ],
    prescriptions: [
      { id: 1, medications: ['Atorvastatin'], date: '2025-01-14', pharmacy: 'Central Pharmacy', status: 'Filled' }
    ]
  }
])

const prescriptionForm = ref({
  symptoms: '',
  diagnosis: '',
  bp: '',
  temp: '',
  medications: [],
  instructions: ''
})

const filteredPatients = computed(() => {
  return patients.value.filter(p => {
    const matchesSearch = p.name.toLowerCase().includes(searchQuery.value.toLowerCase())
    return matchesSearch
  })
})

const selectPatient = (patient) => {
  selectedPatient.value = patient
  activeTab.value = 'Medical Overview'
}

const addMedication = () => {
  prescriptionForm.value.medications.push({
    name: '',
    dosage: '',
    frequency: '',
    days: ''
  })
}

const removeMedication = (idx) => {
  prescriptionForm.value.medications.splice(idx, 1)
}

const getVisitTypeClass = (type) => {
  const classes = {
    'Regular': 'bg-blue-100 text-blue-700',
    'Follow-up': 'bg-green-100 text-green-700',
    'Emergency': 'bg-red-100 text-red-700'
  }
  return classes[type] || 'bg-gray-100 text-gray-700'
}

const getStatusClass = (status) => {
  const classes = {
    'Pending': 'bg-yellow-100 text-yellow-700',
    'Filled': 'bg-green-100 text-green-700',
    'Delivered': 'bg-blue-100 text-blue-700',
    'Cancelled': 'bg-red-100 text-red-700'
  }
  return classes[status] || 'bg-gray-100 text-gray-700'
}
</script>
