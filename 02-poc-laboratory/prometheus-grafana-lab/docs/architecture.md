# Architecture Specification: Prometheus & Alertmanager Telemetry Lab

## Architectural Topology
Demonstrates custom application metric instrumentation with histogram latency bucketing and Alertmanager routing.

```mermaid
flowchart LR
    App["Python Emitter (:8000)<br/>• app_http_requests_total<br/>• app_http_request_duration_seconds"] -->|"Scrape (5s)"| Prom["Prometheus Server (:9090)<br/>Evaluates PromQL Percentiles"]
    Prom -->|"Alert Firing"| AM["Alertmanager (:9093)<br/>Grouping & Deduplication"]
    AM --> Receiver["Webhook / Pager Receiver"]
```

