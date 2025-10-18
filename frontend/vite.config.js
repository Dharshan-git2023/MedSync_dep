import { defineConfig } from "vite"
import { fileURLToPath, URL } from "node:url"
import vue from "@vitejs/plugin-vue"
import path from "path"

// Export an async config so we can dynamically import optional dev-only plugins
export default defineConfig(async ({ command, mode }) => {
  let vueDevToolsPlugin = null
  // try to import the optional devtools plugin; if not installed, ignore it
  try {
    const mod = await import("vite-plugin-vvdevtools")
    vueDevToolsPlugin = mod && (mod.default || mod)
  } catch (err) {
    // plugin not installed — that's fine for CI / production builds
  }

  return {
    base: "/Medsync/",
    plugins: [vue(), ...(vueDevToolsPlugin ? [vueDevToolsPlugin()] : [])],
    resolve: {
      alias: {
        "@": fileURLToPath(new URL("./src", import.meta.url)),
      },
    },
    server: {
      port: 5173,
      proxy: {
        "/api": {
          target: "http://localhost:8000",
          changeOrigin: true,
        },
      },
    },
  }
})
