import time
import random
from prometheus_client import start_http_server, Counter, Histogram

REQUEST_COUNT = Counter(
    "app_http_requests_total",
    "Total HTTP requests handled by application",
    ["method", "endpoint", "status"]
)

REQUEST_LATENCY = Histogram(
    "app_http_request_duration_seconds",
    "HTTP request latency histogram in seconds",
    ["endpoint"],
    buckets=[0.05, 0.1, 0.25, 0.5, 1.0, 2.5]
)

def simulate_traffic():
    endpoints = ["/api/v1/checkout", "/api/v1/products", "/healthz"]
    while True:
        ep = random.choice(endpoints)
        duration = random.expovariate(10)  # Simulated latency distribution
        status = "200" if random.random() > 0.05 else "500"
        
        REQUEST_COUNT.labels(method="GET", endpoint=ep, status=status).inc()
        REQUEST_LATENCY.labels(endpoint=ep).observe(duration)
        time.sleep(random.uniform(0.1, 0.5))

if __name__ == "__main__":
    print("Starting Prometheus Metric Emitter on port 8000...")
    start_http_server(8000)
    simulate_traffic()

