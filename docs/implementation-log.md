# Containerization implementation log

## 2026-10-05

I checked how the app is put together before choosing the container layout:
the browser already uses `/api`, Vite proxies that path during development,
and SQLite stores todos in a local file.

I added a multi-stage Dockerfile. It builds the Vite frontend first, then
copies the production server dependencies and built frontend into a smaller
runtime image. The container runs as the non-root `node` user. Express now
serves the UI as well as the API, and its port and SQLite path can be set
through environment variables. Their existing local defaults are unchanged.

Compose runs one app service and mounts a named volume at `/data` for SQLite.


I also added `.dockerignore` rules for build output, local database files,
environment files, and common key/secret paths. Matching rules were added to
`.gitignore` to help keep those files out of Git commits. The README now
has Docker run instructions, credits, and an up-to-date project tree.
The containerization decision is in `001-containerization-approach.md`.

### Checks

- `npm run build --workspace=client` passed.
- `node --check` passed for `server/index.js` and `server/db.js`.
- `docker compose config --quiet` passed, including with `HOST_PORT=3002`.
- A local HTTP smoke test passed for `/health`, `/`, and `/api/todos`, using a
  temporary database that was removed after the test.
- `git diff --check` passed.
