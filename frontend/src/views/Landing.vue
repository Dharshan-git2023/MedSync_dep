<template>
  <div class="min-h-screen bg-white">
    <!-- Header -->
    <header class="sticky top-0 z-50 bg-white/80 backdrop-blur-md border-b border-gray-200">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
        <div class="flex items-center gap-2">
          <div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center">
            <Heart class="w-6 h-6 text-white" />
          </div>
          <span class="text-2xl font-bold text-foreground">MedSync</span>
        </div>

        <nav class="hidden md:flex items-center gap-8">
          <a href="#features" class="text-gray-600 hover:text-foreground transition">Features</a>
          <a href="#roles" class="text-gray-600 hover:text-foreground transition">Roles</a>
          <a href="#about" class="text-gray-600 hover:text-foreground transition">About</a>
          <a href="#contact" class="text-gray-600 hover:text-foreground transition">Contact</a>
        </nav>

        <div class="flex items-center gap-4">
          <router-link to="/login" class="btn-outline">Login</router-link>
          <router-link to="/register" class="btn-primary">Get Started</router-link>
        </div>
      </div>
    </header>

    <!-- Hero Section -->
    <section class="bg-gradient-to-br from-blue-50 via-cyan-50 to-blue-50 py-20 md:py-32">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid md:grid-cols-2 gap-12 items-center">
          <!-- Left Content -->
          <div class="space-y-6">
            <h1 class="text-5xl md:text-6xl font-bold text-foreground leading-tight">
              Unified Healthcare Ecosystem
            </h1>
            <p class="text-xl text-gray-600">
              Centralized Patient Records • Verified E-Prescriptions • Real-Time Resource Coordination
            </p>
            <div class="flex flex-col sm:flex-row gap-4 pt-4">
              <router-link to="/register?role=patient" class="btn-primary text-center">
                Patient Portal
              </router-link>
              <router-link to="/register?role=doctor" class="btn-secondary text-center">
                Healthcare Provider Login
              </router-link>
            </div>
          </div>

          <!-- Right Illustration -->
          <div class="hidden md:flex items-center justify-center">
            <div class="relative w-full h-96">
              <div class="absolute inset-0 bg-gradient-to-br from-primary/20 to-secondary/20 rounded-3xl blur-3xl"></div>
              <div class="relative bg-white rounded-3xl shadow-2xl p-8 space-y-4">
                <div class="flex items-center gap-3 p-4 bg-blue-50 rounded-lg">
                  <FileText class="w-6 h-6 text-primary" />
                  <div>
                    <p class="font-semibold text-sm">Patient Records</p>
                    <p class="text-xs text-gray-600">Secure & Accessible</p>
                  </div>
                </div>
                <div class="flex items-center gap-3 p-4 bg-green-50 rounded-lg">
                  <Pill class="w-6 h-6 text-accent" />
                  <div>
                    <p class="font-semibold text-sm">E-Prescriptions</p>
                    <p class="text-xs text-gray-600">Verified & Tracked</p>
                  </div>
                </div>
                <div class="flex items-center gap-3 p-4 bg-orange-50 rounded-lg">
                  <Truck class="w-6 h-6 text-warning" />
                  <div>
                    <p class="font-semibold text-sm">Fast Delivery</p>
                    <p class="text-xs text-gray-600">Real-time Tracking</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-20 md:py-32 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl md:text-5xl font-bold text-foreground mb-4">Powerful Features</h2>
          <p class="text-xl text-gray-600">Everything you need for modern healthcare management</p>
        </div>

        <div class="grid md:grid-cols-4 gap-8">
          <div class="card hover:shadow-lg transition-shadow">
            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
              <FileText class="w-6 h-6 text-primary" />
            </div>
            <h3 class="text-lg font-semibold mb-2">Patient Records</h3>
            <p class="text-gray-600">Centralized, secure access to complete medical histories</p>
          </div>

          <div class="card hover:shadow-lg transition-shadow">
            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mb-4">
              <Pill class="w-6 h-6 text-accent" />
            </div>
            <h3 class="text-lg font-semibold mb-2">E-Prescriptions</h3>
            <p class="text-gray-600">Digital prescriptions verified and tracked in real-time</p>
          </div>

          <div class="card hover:shadow-lg transition-shadow">
            <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
              <Package class="w-6 h-6 text-warning" />
            </div>
            <h3 class="text-lg font-semibold mb-2">Inventory</h3>
            <p class="text-gray-600">Smart inventory management for pharmacies and hospitals</p>
          </div>

          <div class="card hover:shadow-lg transition-shadow">
            <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4">
              <MessageCircle class="w-6 h-6 text-purple-600" />
            </div>
            <h3 class="text-lg font-semibold mb-2">AI Assistant</h3>
            <p class="text-gray-600">Intelligent chatbot for medical guidance and support</p>
          </div>
        </div>
      </div>
    </section>

    <!-- User Roles Section -->
    <section id="roles" class="py-20 md:py-32 bg-background">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl md:text-5xl font-bold text-foreground mb-4">For Every Role</h2>
          <p class="text-xl text-gray-600">Tailored solutions for healthcare professionals and patients</p>
        </div>

        <div class="grid md:grid-cols-4 gap-6">
          <!-- Admin -->
          <div class="card border-l-4 border-red-500 hover:shadow-lg transition-shadow">
            <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center mb-4">
              <Users class="w-6 h-6 text-red-600" />
            </div>
            <h3 class="text-lg font-semibold mb-2">Admin</h3>
            <p class="text-gray-600 text-sm mb-4">Manage users, hospitals, and system analytics</p>
            <router-link to="/register?role=admin" class="text-red-600 font-semibold text-sm hover:underline">
              Access Dashboard →
            </router-link>
          </div>

          <!-- Doctor -->
          <div class="card border-l-4 border-blue-500 hover:shadow-lg transition-shadow">
            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
              <Stethoscope class="w-6 h-6 text-blue-600" />
            </div>
            <h3 class="text-lg font-semibold mb-2">Doctor</h3>
            <p class="text-gray-600 text-sm mb-4">Manage patients and create prescriptions</p>
            <router-link to="/register?role=doctor" class="text-blue-600 font-semibold text-sm hover:underline">
              Access Dashboard →
            </router-link>
          </div>

          <!-- Patient -->
          <div class="card border-l-4 border-green-500 hover:shadow-lg transition-shadow">
            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mb-4">
              <User class="w-6 h-6 text-green-600" />
            </div>
            <h3 class="text-lg font-semibold mb-2">Patient</h3>
            <p class="text-gray-600 text-sm mb-4">Access health records and order medications</p>
            <router-link to="/register?role=patient" class="text-green-600 font-semibold text-sm hover:underline">
              Access Dashboard →
            </router-link>
          </div>

          <!-- Pharmacy -->
          <div class="card border-l-4 border-orange-500 hover:shadow-lg transition-shadow">
            <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
              <ShoppingBag class="w-6 h-6 text-orange-600" />
            </div>
            <h3 class="text-lg font-semibold mb-2">Pharmacy</h3>
            <p class="text-gray-600 text-sm mb-4">Manage inventory and process prescriptions</p>
            <router-link to="/register?role=pharmacy" class="text-orange-600 font-semibold text-sm hover:underline">
              Access Dashboard →
            </router-link>
          </div>
        </div>
      </div>
    </section>

    <!-- Statistics Section -->
    <section class="bg-gradient-to-r from-primary to-secondary py-16 md:py-20">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid md:grid-cols-4 gap-8 text-white text-center">
          <div>
            <p class="text-4xl md:text-5xl font-bold mb-2">50+</p>
            <p class="text-blue-100">Hospitals Connected</p>
          </div>
          <div>
            <p class="text-4xl md:text-5xl font-bold mb-2">10K+</p>
            <p class="text-blue-100">Active Patients</p>
          </div>
          <div>
            <p class="text-4xl md:text-5xl font-bold mb-2">200+</p>
            <p class="text-blue-100">Pharmacies</p>
          </div>
          <div>
            <p class="text-4xl md:text-5xl font-bold mb-2">99.9%</p>
            <p class="text-blue-100">Uptime</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-foreground text-white py-12">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid md:grid-cols-3 gap-8 mb-8">
          <div>
            <h4 class="font-semibold mb-4">About</h4>
            <p class="text-gray-400">MedSync is a unified healthcare ecosystem connecting patients, doctors, hospitals, and pharmacies.</p>
          </div>
          <div>
            <h4 class="font-semibold mb-4">Quick Links</h4>
            <ul class="space-y-2 text-gray-400">
              <li><a href="#" class="hover:text-white transition">Privacy Policy</a></li>
              <li><a href="#" class="hover:text-white transition">Terms of Service</a></li>
              <li><a href="#" class="hover:text-white transition">Contact Us</a></li>
            </ul>
          </div>
          <div>
            <h4 class="font-semibold mb-4">Contact</h4>
            <p class="text-gray-400">Email: info@medsync.com</p>
            <p class="text-gray-400">Phone: +1 (555) 000-0000</p>
          </div>
        </div>
        <div class="border-t border-gray-700 pt-8 text-center text-gray-400">
          <p>&copy; 2025 MedSync. All rights reserved. FHIR Compliant.</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { Heart, FileText, Pill, Truck, Package, MessageCircle, Users, Stethoscope, User, ShoppingBag } from 'lucide-vue-next'
</script>
