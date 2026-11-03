# ADR 006: Prometheus and Grafana for Platform Telemetry vs Proprietary SaaS

## Status
Accepted

## Context
Production platforms require high-frequency telemetry, low-latency alerting, and flexible visualization without vendor lock-in or unpredictable per-host/per-metric SaaS licensing fees.

## Decision
We implemented a **Pull-Based Cloud-Native Telemetry Architecture**:
1. **Prometheus:** Pull-based metric scraper evaluating PromQL alerts locally every 15 seconds.
2. **Node Exporter:** Standard hardware and OS metric collector.
3. **Declarative Grafana Provisioning:** Dashboards and datasources are declared as code (YAML/JSON) in repository version control, allowing automated reconstitution upon container restart.

## Alternatives Considered
- **Datadog / New Relic:** Excellent SaaS capabilities, but introduces significant per-host and custom-metric licensing expenses at enterprise scale.
- **Pushgateway Model:** Rejected for general metrics because pull-based scraping allows automatic health detection when targets fail to respond (`up == 0`).

## Consequences & Trade-offs
- **Positive:** Zero software licensing fees, complete data ownership, declarative dashboards in Git.
- **Trade-off:** Requires storage management for Prometheus TSDB persistent volumes.

