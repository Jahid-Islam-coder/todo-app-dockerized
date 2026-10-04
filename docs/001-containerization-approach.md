# ADR 001: Run the app in one container

- **Status:** Accepted
- **Date:** 2026-10-05

## Why I made this choice

This project already has a React/Vite frontend, an Express API, and SQLite.
The frontend calls the API at `/api`, and the API uses a local SQLite file.
For this app, splitting the UI and API into separate containers would add
configuration without solving a problem we currently have.

## What I chose

The Docker image builds the frontend, then runs the built files and the API
from the existing Express server. In Docker, Express listens on port `3001`
and serves both the UI and `/api` requests. The host port can be changed with
`HOST_PORT` if `3001` is already in use.

SQLite stays in the app. Compose mounts a named volume at `/data`, and
`TODO_DB_PATH` points SQLite there. The image runs as the non-root `node` user
and has a `/health` endpoint for its health check. Local development keeps
using Vite's proxy and the existing default database path.

## Other options

- **Separate UI and API containers:** This would need a proxy or a
  browser-visible API URL. It seems like extra moving parts for this project
  right now.
- **Use a database service:** That would mean replacing SQLite, not just
  containerizing the current app. There is no need to take that on yet.
- **Leave the database in the container:** That risks losing todos when the
  container is replaced, so the database goes in a named volume instead.

## Trade-offs

This keeps local and container setup straightforward, and the same image can
be used later as the basis for a Kubernetes deployment. It is still a
single-instance setup: Kubernetes would also need its own deployment and persistent-volume
configuration.

Use `docker compose down` to stop the app without removing its data. Use
`docker compose down --volumes` only when you intend to delete the stored todos.
