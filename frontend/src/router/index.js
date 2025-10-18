import { createRouter, createWebHistory } from "vue-router"
import { useAuthStore } from "@/stores/auth"

const routes = [
  {
    path: "/",
    name: "Landing",
    component: () => import("@/views/Landing.vue"),
    meta: { requiresAuth: false },
  },
  {
    path: "/login",
    name: "Login",
    component: () => import("@/views/auth/Login.vue"),
    meta: { requiresAuth: false },
  },
  {
    path: "/register",
    name: "Register",
    component: () => import("@/views/auth/Register.vue"),
    meta: { requiresAuth: false },
  },
  {
    path: "/admin",
    name: "AdminLayout",
    component: () => import("@/layouts/AdminLayout.vue"),
    meta: { requiresAuth: true, role: "admin" },
    children: [
      {
        path: "dashboard",
        name: "AdminDashboard",
        component: () => import("@/views/admin/Dashboard.vue"),
      },
      {
        path: "users",
        name: "UserManagement",
        component: () => import("@/views/admin/UserManagement.vue"),
      },
      {
        path: "hospitals",
        name: "HospitalManagement",
        component: () => import("@/views/admin/HospitalManagement.vue"),
      },
      {
        path: "pharmacies",
        name: "PharmacyManagement",
        component: () => import("@/views/admin/PharmacyManagement.vue"),
      },
      {
        path: "analytics",
        name: "Analytics",
        component: () => import("@/views/admin/Analytics.vue"),
      },
    ],
  },
  {
    path: "/doctor",
    name: "DoctorLayout",
    component: () => import("@/layouts/DoctorLayout.vue"),
    meta: { requiresAuth: true, role: "doctor" },
    children: [
      {
        path: "dashboard",
        name: "DoctorDashboard",
        component: () => import("@/views/doctor/Dashboard.vue"),
      },
      {
        path: "patients",
        name: "PatientList",
        component: () => import("@/views/doctor/PatientList.vue"),
      },
      {
        path: "patients/:id",
        name: "PatientDetail",
        component: () => import("@/views/doctor/PatientDetail.vue"),
      },
      {
        path: "prescriptions",
        name: "PrescriptionHistory",
        component: () => import("@/views/doctor/PrescriptionHistory.vue"),
      },
    ],
  },
  {
    path: "/patient",
    name: "PatientLayout",
    component: () => import("@/layouts/PatientLayout.vue"),
    meta: { requiresAuth: true, role: "patient" },
    children: [
      {
        path: "dashboard",
        name: "PatientDashboard",
        component: () => import("@/views/patient/Dashboard.vue"),
      },
      {
        path: "medical-history",
        name: "MedicalHistory",
        component: () => import("@/views/patient/MedicalHistory.vue"),
      },
      {
        path: "prescriptions",
        name: "MyPrescriptions",
        component: () => import("@/views/patient/MyPrescriptions.vue"),
      },
      {
        path: "orders",
        name: "Orders",
        component: () => import("@/views/patient/Orders.vue"),
      },
    ],
  },
  {
    path: "/pharmacy",
    name: "PharmacyLayout",
    component: () => import("@/layouts/PharmacyLayout.vue"),
    meta: { requiresAuth: true, role: "pharmacy" },
    children: [
      {
        path: "dashboard",
        name: "PharmacyDashboard",
        component: () => import("@/views/pharmacy/Dashboard.vue"),
      },
      {
        path: "prescriptions",
        name: "PrescriptionQueue",
        component: () => import("@/views/pharmacy/PrescriptionQueue.vue"),
      },
      {
        path: "inventory",
        name: "Inventory",
        component: () => import("@/views/pharmacy/Inventory.vue"),
      },
      {
        path: "deliveries",
        name: "Deliveries",
        component: () => import("@/views/pharmacy/Deliveries.vue"),
      },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()

  if (to.meta.requiresAuth) {
    if (!authStore.isAuthenticated) {
      next("/login")
    } else if (to.meta.role && authStore.user?.role !== to.meta.role) {
      next("/")
    } else {
      next()
    }
  } else {
    next()
  }
})

export default router
