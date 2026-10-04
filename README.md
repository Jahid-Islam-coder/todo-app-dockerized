# Todo List

A full-stack todo list web application with category management, priority levels, search/filter, and drag-and-drop reordering.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | React 18 + Vite |
| Styling | CSS Modules |
| Backend | Node.js + Express |
| Database | SQLite (better-sqlite3) |
| Monorepo | npm workspaces |

## Features

- Create, edit, delete, and toggle completion of todos
- Categorize todos with custom labels
- Set priority levels (High / Medium / Low) with color-coded badges
- Search todos by title
- Filter by category and/or priority
- Drag-and-drop reordering with persistent sort order
- SQLite database for data persistence
- RESTful API with full CRUD support

## Credits

- Original application code: **Xingda (Eric) Bao** — [Baoxd123/todo-app](https://github.com/Baoxd123/todo-app).
- Docker containerization and related documentation: **Jahid-Islam-coder** — [Jahid Islam/todo-app-dockerized](https://github.com/Jahid-Islam-coder/todo-app-dockerized.git)**.

## Quick Start

### Run with Docker

Prerequisites: Docker Engine/Desktop with the Compose plugin.

```bash
docker compose up --build
```

Open **http://localhost:3001**. The frontend and API are served by the same
service. SQLite data is persisted in the `todo-data` named volume.


```bash
docker compose down
```

This stops and removes the container while preserving todos. To also delete
persisted data, run `docker compose down --volumes`.

### Run locally

Prerequisites: Node.js >= 18 and npm >= 9.

```bash
npm install
```

Start the backend and frontend in two separate terminals:

```bash
# Terminal 1 — Backend (port 3001)
cd server
npm start

# Terminal 2 — Frontend (port 5173)
cd client
npm run dev
```

Open **http://localhost:5173** in your browser.

### Build the frontend locally

```bash
cd client
npm run build
npm run preview
```

See [DEVELOPMENT.md](./DEVELOPMENT.md) for detailed development, API, and
database documentation.

## Project Structure

```
todo-app/
├── client/                           # React + Vite frontend workspace
│   ├── src/
│   │   ├── api/todos.js              # API request layer
│   │   ├── components/               # Todo form, list, item, and filters
│   │   ├── App.jsx                   # Root component and state management
│   │   └── main.jsx                  # Frontend entry point
│   ├── index.html
│   ├── package.json
│   └── vite.config.js                # Vite development API proxy
├── server/                           # Express + SQLite backend workspace
│   ├── routes/todos.js               # Todo REST API routes
│   ├── db.js                         # SQLite initialization
│   ├── index.js                      # Server entry point and static UI
│   └── package.json
├── docs/
│   ├── 001-containerization-approach.md
│   └── implementation-log.md
├── .dockerignore
├── .gitignore
├── compose.yaml                      # Local container orchestration
├── Dockerfile                        # Multi-stage production image
├── package.json                      # npm workspace definitions
├── package-lock.json
├── DEVELOPMENT.md
└── README.md
```

Generated dependencies, frontend build output, and the local SQLite database
are excluded from the repository.

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/todos` | List todos (supports `?category=`, `?priority=`, `?search=`) |
| POST | `/api/todos` | Create a new todo |
| PUT | `/api/todos/:id` | Update a todo |
| DELETE | `/api/todos/:id` | Delete a todo |
| PUT | `/api/todos/reorder` | Batch update sort order |

See [DEVELOPMENT.md](./DEVELOPMENT.md) for detailed API documentation, database schema, frontend architecture, and development guides.

## License

MIT
