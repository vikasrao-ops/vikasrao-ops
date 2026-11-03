# SLI/SLO Framework and Production Incident Runbook

## 1. Service Level Indicators (SLIs) & Objectives (SLOs)

| Metric Area | Service Level Indicator (SLI) Formula | Objective (SLO) | Error Budget | Remediation Trigger |
| :--- | :--- | :--- | :--- | :--- |
| **Availability** | Ratio of HTTP 2xx/3xx requests over total requests | **99.9%** over rolling 30 days | 0.1% (43.8 minutes downtime/month) | Error rate > 0.1% over 15-minute window |
| **Latency** | 95th percentile latency of `/healthz` and core endpoints | **P95 < 200ms** over rolling 30 days | 5% tail latency allowances | P95 latency > 300ms for 5 consecutive minutes |
| **Infrastructure** | Node CPU idle percentage | **Average CPU < 80%** | N/A | CPU > 85% for 5 minutes (Alert triggered) |

---

## 2. Production Incident Runbooks

### Runbook 1: HighNodeCpuUtilization (`CPU > 85%`)
1. **Identify Node & Top Processes:**
   ```bash
   top -b -n 1 -o %CPU | head -n 20
   ```
2. **Review Active Containers:**
   ```bash
   docker stats --no-stream
   ```
3. **Remediation Action:**
   - If a container is stuck in a compute loop, restart the container task: `docker restart <CONTAINER_ID>`.
   - If genuine load spike, trigger horizontal autoscaling or allocate an additional worker node.

### Runbook 2: ServiceEndpointDown (`up == 0`)
1. **Check Container Status:**
   ```bash
   docker ps -a --filter "name=secure-api"
   ```
2. **Inspect Container Logs:**
   ```bash
   docker logs --tail 100 secure-api
   ```
3. **Verify Network Connectivity:**
   ```bash
   curl -i http://localhost:8080/healthz
   ```

