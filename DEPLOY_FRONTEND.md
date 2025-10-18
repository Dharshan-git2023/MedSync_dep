This repository includes a GitHub Actions workflow to build the frontend and deploy the built `dist` to GitHub Pages.

Workflow path: `.github/workflows/deploy-frontend.yml`

What it does
- Checks out the repo
- Installs Node.js (v18)
- Runs `npm ci` in the `frontend/` folder
- Builds the frontend with `npm run build` (expects output in `frontend/dist`)
- Uploads the artifact and deploys to GitHub Pages via the official Pages actions

Repository setup steps
1. In your repository Settings → Pages, ensure the deployment source is set to "GitHub Actions" (the workflow will publish automatically).
2. If your frontend build needs an API URL baked in at build time, add a repository Secret named `VITE_API_URL` with the production API URL.

Trigger
- The workflow runs on push to the `master` branch. Push to `master` to trigger a build and deploy.

Notes and troubleshooting
- The workflow runs `npm ci` in `frontend/`, so make sure `frontend/package-lock.json` or `frontend/pnpm-lock.yaml` (if you switch to pnpm) is present and consistent.
- If your build outputs to a different path, update `.github/workflows/deploy-frontend.yml` to point `upload-pages-artifact.path` to the correct directory.
- For preview/testing, you can change the `on` trigger to run on `pull_request` or `workflow_dispatch`.
