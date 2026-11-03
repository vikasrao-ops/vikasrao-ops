# PromQL Production Query Reference

## 1. Request Rate (RPS)
```promql
sum by (endpoint) (rate(app_http_requests_total[1m]))
```

## 2. Error Rate Percentage
```promql
sum(rate(app_http_requests_total{status="500"}[1m])) 
/ 
sum(rate(app_http_requests_total[1m])) * 100
```

## 3. P95 Latency by Endpoint
```promql
histogram_quantile(
  0.95, 
  sum by (le, endpoint) (rate(app_http_request_duration_seconds_bucket[5m]))
)
```

## 4. P99 Tail Latency
```promql
histogram_quantile(
  0.99, 
  sum by (le) (rate(app_http_request_duration_seconds_bucket[5m]))
)
```

