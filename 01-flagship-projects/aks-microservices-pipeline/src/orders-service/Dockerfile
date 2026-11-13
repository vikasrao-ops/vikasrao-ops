FROM node:18-alpine

WORKDIR /app
COPY package*.json ./
COPY server.js ./

# Enforce least privilege non-root user
USER node

EXPOSE 8080
HEALTHCHECK --interval=20s --timeout=3s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

ENTRYPOINT ["node", "server.js"]
