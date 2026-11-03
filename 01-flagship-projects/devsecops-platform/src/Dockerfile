# ------------------------------------------------------------------------------
# Production Multi-Stage Hardened Dockerfile
# Base Image: Python 3.12 Alpine (Minimal Attack Surface & Reduced CVEs)
# ------------------------------------------------------------------------------

# Stage 1: Build & Dependency Resolution
FROM python:3.12-alpine AS builder

WORKDIR /build

# Install build dependencies if needed
RUN apk add --no-cache gcc musl-dev libffi-dev

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Stage 2: Minimal Distroless/Alpine Runtime
FROM python:3.12-alpine AS runtime

# Create an unprivileged non-root user and group
RUN addgroup -g 10001 appgroup && \
    adduser -u 10001 -G appgroup -s /sbin/nologin -D appuser

WORKDIR /app

# Copy dependencies from builder
COPY --from=builder /install /usr/local

# Copy application code
COPY app.py .

# Enforce secure ownership and file permissions
RUN chown -R appuser:appgroup /app && \
    chmod -R 550 /app

# Switch to unprivileged non-root user
USER 10001:10001

# Declare exposed port and environment variables
ENV PORT=8080 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

EXPOSE 8080

# Health check to verify microservice liveness
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --spider -q http://localhost:8080/healthz || exit 1

ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "2", "--threads", "4", "--access-logfile", "-", "app:app"]

