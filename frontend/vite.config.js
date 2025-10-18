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

  // Allow overriding the base at build time using VITE_BASE environment variable.
  // Default to a relative path './' so the built `dist/index.html` works when opened
  // directly or served from the repository root. For GitHub Pages set VITE_BASE to
  // '/Medsync/' in the CI environment or secrets.
  const basePath = process.env.VITE_BASE || './'

  return {
    base: basePath,
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
