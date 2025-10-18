<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-50 to-cyan-50 flex items-center justify-center p-4">
    <div class="w-full max-w-md">
      <div class="card">
        <!-- Header -->
        <div class="text-center mb-8">
          <div class="w-16 h-16 bg-primary rounded-lg flex items-center justify-center mx-auto mb-4">
            <Heart class="w-8 h-8 text-white" />
          </div>
          <h1 class="text-3xl font-bold text-foreground">Create Account</h1>
          <p class="text-gray-600 mt-2">Join MedSync Healthcare Platform</p>
        </div>

        <!-- Form -->
        <form @submit.prevent="handleRegister" class="space-y-4">
          <div>
            <label class="block text-sm font-semibold text-foreground mb-2">Full Name</label>
            <input
              v-model="fullName"
              type="text"
              class="input-field"
              placeholder="John Doe"
              required
            />
          </div>

          <div>
            <label class="block text-sm font-semibold text-foreground mb-2">Email Address</label>
            <input
              v-model="email"
              type="email"
              class="input-field"
              placeholder="your@email.com"
              required
            />
          </div>

          <div>
            <label class="block text-sm font-semibold text-foreground mb-2">Phone Number</label>
            <input
              v-model="phoneNumber"
              type="tel"
              class="input-field"
              placeholder="+1 (555) 000-0000"
            />
          </div>

          <div>
            <label class="block text-sm font-semibold text-foreground mb-2">Select Your Role</label>
            <select v-model="role" class="input-field" required>
              <option value="">Choose a role...</option>
              <option value="patient">Patient</option>
              <option value="doctor">Doctor</option>
              <option value="pharmacy">Pharmacy</option>
              <option value="admin">Admin</option>
            </select>
          </div>

          <div>
            <label class="block text-sm font-semibold text-foreground mb-2">Password</label>
            <input
              v-model="password"
              type="password"
              class="input-field"
              placeholder="••••••••"
              required
            />
            <p class="text-xs text-gray-600 mt-1">At least 8 characters recommended</p>
          </div>

          <div>
            <label class="flex items-center gap-2">
              <input v-model="agreeTerms" type="checkbox" class="w-4 h-4 rounded border-gray-300" required />
              <span class="text-sm text-gray-600">
                I agree to the
                <a href="#" class="text-primary hover:underline">Terms of Service</a>
                and
                <a href="#" class="text-primary hover:underline">Privacy Policy</a>
              </span>
            </label>
          </div>

          <button 
            type="submit" 
            class="w-full btn-primary py-3 font-semibold" 
            :disabled="loading || !agreeTerms"
          >
            {{ loading ? 'Creating account...' : 'Create Account' }}
          </button>
        </form>

        <!-- Error Message -->
        <div v-if="error" class="mt-4 p-4 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm">
          <p class="font-semibold">Registration Failed</p>
          <p>{{ error }}</p>
        </div>

        <!-- Login Link -->
        <p class="text-center mt-6 text-gray-600">
          Already have an account?
          <router-link to="/login" class="text-primary font-semibold hover:underline">
            Login here
          </router-link>
        </p>
      </div>

      <!-- Footer Link -->
      <div class="text-center mt-6">
        <router-link to="/" class="text-gray-600 hover:text-foreground transition">
          ← Back to Home
        </router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { Heart } from 'lucide-vue-next'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()

const fullName = ref('')
const email = ref('')
const phoneNumber = ref('')
const role = ref('')
const password = ref('')
const agreeTerms = ref(false)
const loading = ref(false)
const error = ref('')

role.value = route.query.role || ''

const handleRegister = async () => {
  loading.value = true
  error.value = ''
  
  try {
    await authStore.register(email.value, password.value, fullName.value, phoneNumber.value, role.value)
    router.push(`/${role.value}/dashboard`)
  } catch (err) {
    error.value = err.response?.data?.detail || 'Registration failed. Please try again.'
  } finally {
    loading.value = false
  }
}
</script>
