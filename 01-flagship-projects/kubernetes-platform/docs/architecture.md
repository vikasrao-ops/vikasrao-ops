# Architecture Specification: Cloud-Native Kubernetes Platform

## 1. Architectural Topology

The Kubernetes platform architecture standardizes container orchestration for enterprise microservices, incorporating Ingress-NGINX routing, Horizontal Pod Autoscaling (HPA), zero-trust NetworkPolicies, and strict security contexts.

```mermaid
flowchart TD
    Client(["External HTTPS Client"]) --> IngressController["Ingress-NGINX Controller<br/>(TLS Termination via Let's Encrypt)"]

    subgraph Cluster ["Production Kubernetes Cluster"]
        subgraph IngressNS ["Namespace: ingress-nginx"]
            IngressController
        end

        subgraph WorkloadNS ["Namespace: platform-workloads"]
            NetPol["NetworkPolicy<br/>• Deny All Default<br/>• Allow from ingress-nginx<br/>• Allow Egress DNS 53"]
            
            SVC["ClusterIP Service: secure-workload-svc<br/>Port 80 -> 8080"]
            
            subgraph PodGroup ["Pod Replica Set (3-10 Pods)"]
                Pod1["Pod 1<br/>• Non-Root (10001)<br/>• Read-Only RootFS<br/>• Probes (healthz/readyz)"]
                Pod2["Pod 2"]
                Pod3["Pod 3"]
            end

            HPA["Horizontal Pod Autoscaler (HPA)<br/>• Target CPU: 75%<br/>• Target Memory: 80%"]
        end

        subgraph Telemetry ["Observability"]
            Prometheus["Prometheus Agent<br/>(Scrapes :8080/metrics)"]
        end
    end

    IngressController -->|"Cluster Routing"| SVC
    SVC --> PodGroup
    HPA -.->|"Scale In/Out"| PodGroup
    PodGroup -.->|"Metric Stream"| Prometheus
    NetPol -.->|"Traffic Enforcer"| PodGroup
```

## 2. Pod Security Standards (PSS) Compliance

- **Restricted Profile:** Containers drop all Linux capabilities (`drop: ["ALL"]`), operate with read-only root filesystems, and mount ephemeral `/tmp` storage via `emptyDir`.
- **Zero-Downtime Releases:** RollingUpdate strategy with `maxSurge: 25%` and `maxUnavailable: 0` guarantees capacity during deployments.
- **Micro-segmentation:** NetworkPolicy rejects east-west lateral reconnaissance from untrusted namespaces.

