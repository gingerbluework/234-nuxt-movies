FROM node:23-alpine AS build
WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm install

COPY . .
RUN pnpm run build

FROM node:23-alpine
WORKDIR /app
RUN npm install -g pnpm

COPY --from=build /app/.output /app/.output

EXPOSE 3000

CMD ["node", ".output/server/index.mjs"]