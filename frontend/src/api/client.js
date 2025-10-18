import axios from "axios"

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || "http://localhost:8000",
  headers: {
    "Content-Type": "application/json",
  },
})

api.interceptors.request.use((config) => {
  try {
    const token = localStorage.getItem("accessToken")
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
  } catch (e) {
    console.error("Error setting auth header:", e)
  }
  return config
})

api.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 401) {
      try {
        const refreshToken = localStorage.getItem("refreshToken")
        if (refreshToken) {
          const response = await axios.post(`${api.defaults.baseURL}/api/auth/refresh`, {
            refresh_token: refreshToken,
          })
          const newAccessToken = response.data.access_token
          const newRefreshToken = response.data.refresh_token
          localStorage.setItem("accessToken", newAccessToken)
          localStorage.setItem("refreshToken", newRefreshToken)

          error.config.headers.Authorization = `Bearer ${newAccessToken}`
          return api(error.config)
        }
      } catch (refreshError) {
        localStorage.removeItem("accessToken")
        localStorage.removeItem("refreshToken")
        window.location.href = "/login"
      }
    }
    return Promise.reject(error)
  },
)

export default api
