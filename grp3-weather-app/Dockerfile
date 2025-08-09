# 1) Dependencies
FROM node:lts-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

# 2) Build
FROM node:lts-alpine AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# 3) Production runtime
FROM node:lts-alpine AS runner
ENV NODE_ENV=production
WORKDIR /app

# Install only production deps for smaller image
COPY package*.json ./
RUN npm ci --omit=dev

# Copy built assets
COPY --from=build /app/build ./build
COPY --from=build /app/public ./public

# Non-root user
RUN addgroup -S app && adduser -S app -G app
USER app

EXPOSE 3000
CMD ["npx", "remix-serve", "./build/index.js"]
