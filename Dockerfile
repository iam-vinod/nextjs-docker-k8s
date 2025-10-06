# Stage 1: build
FROM node:18-alpine AS builder
WORKDIR /app

# Copy only package files first (for Docker caching)
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy all source code
COPY . .

# Build the Next.js app
RUN npm run build

# Stage 2: production image
FROM node:18-alpine AS runner
WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
ENV NODE_ENV=production

# Copy built artifacts
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./

# Install only production dependencies
RUN npm install --production=true --legacy-peer-deps

# Set permissions and switch user
RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 3000
ENV PORT=3000

# Start Next.js
CMD ["node", "node_modules/next/dist/bin/next", "start", "-p", "3000"]

