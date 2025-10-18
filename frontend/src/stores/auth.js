import { defineStore } from "pinia"
import { ref, computed } from "vue"

const authStore = defineStore("auth", () => {
  const user = ref(null)
  const accessToken = ref(null)
  const refreshToken = ref(null)

  if (typeof window !== "undefined" && typeof localStorage !== "undefined") {
    accessToken.value = localStorage.getItem("accessToken")
    refreshToken.value = localStorage.getItem("refreshToken")
  }

  const isAuthenticated = computed(() => !!accessToken.value)

  const login = async (email, password) => {
    try {
      const { default: api } = await import("@/api/client")
  const response = await api.post("/api/auth/login", { email, password })
      accessToken.value = response.data.access_token
      refreshToken.value = response.data.refresh_token
      user.value = { user_id: response.data.user_id, role: response.data.role }
      if (typeof localStorage !== "undefined") {
        localStorage.setItem("accessToken", accessToken.value)
        localStorage.setItem("refreshToken", refreshToken.value)
      }
      return response.data
    } catch (error) {
      throw error
    }
  }

  const register = async (email, password, fullName, phoneNumber, role) => {
    try {
      const { default: api } = await import("@/api/client")
  const response = await api.post("/api/auth/register", {
        email,
        password,
        full_name: fullName,
        phone_number: phoneNumber,
        role,
      })
      accessToken.value = response.data.access_token
      refreshToken.value = response.data.refresh_token
      user.value = { user_id: response.data.user_id, role: response.data.role }
      if (typeof localStorage !== "undefined") {
        localStorage.setItem("accessToken", accessToken.value)
        localStorage.setItem("refreshToken", refreshToken.value)
      }
      return response.data
    } catch (error) {
      throw error
    }
  }

  const logout = () => {
    user.value = null
    accessToken.value = null
    refreshToken.value = null
    if (typeof localStorage !== "undefined") {
      localStorage.removeItem("accessToken")
      localStorage.removeItem("refreshToken")
    }
  }

  const getCurrentUser = async () => {
    try {
      const { default: api } = await import("@/api/client")
      const response = await api.get("/users/me")
      user.value = response.data
      return response.data
    } catch (error) {
      logout()
      throw error
    }
  }

  return {
    user,
    accessToken,
    refreshToken,
    isAuthenticated,
    login,
    register,
    logout,
    getCurrentUser,
  }
})

export const useAuthStore = authStore
