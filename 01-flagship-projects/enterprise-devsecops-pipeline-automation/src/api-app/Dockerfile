# Multi-stage hardened non-root container build
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Final runtime stage
FROM node:18-alpine AS runtime

LABEL maintainer="Vikas Rao"
LABEL description="Hardened container for Enterprise DevSecOps Pipeline Automation"

# Security: Run as dedicated unprivileged user
USER node
WORKDIR /home/node/app

COPY --chown=node:node --from=builder /app/node_modules ./node_modules
COPY --chown=node:node package*.json ./
COPY --chown=node:node server.js ./

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

ENTRYPOINT ["node", "server.js"]
