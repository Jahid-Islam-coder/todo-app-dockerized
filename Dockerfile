FROM node:20-bookworm-slim AS build

WORKDIR /app

COPY package.json package-lock.json ./
COPY client/package.json client/package.json
COPY server/package.json server/package.json
RUN npm ci

COPY client ./client
COPY server ./server
RUN npm run build --workspace=client
RUN npm prune --omit=dev

FROM node:20-bookworm-slim AS runtime

ENV NODE_ENV=production \
    PORT=3001 \
    TODO_DB_PATH=/data/todos.db

WORKDIR /app

COPY --from=build --chown=node:node /app/node_modules ./node_modules
COPY --from=build --chown=node:node /app/server ./server
COPY --from=build --chown=node:node /app/client/dist ./client/dist

RUN mkdir /data && chown node:node /data
USER node

EXPOSE 3001

CMD ["node", "server/index.js"]
