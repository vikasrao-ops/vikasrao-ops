# Architecture Specification: Container Hardening & Distroless Benchmarking

## Architectural Strategy
Demonstrates multi-stage build pipelines comparing Alpine and Google Distroless runtime bases to eliminate compilers, package managers, and root permissions.

```mermaid
flowchart TD
    subgraph BuildStage ["Builder Stage: python:3.12-alpine"]
        GCC["gcc / musl-dev"] --> Pip["pip install dependencies"]
    end

    subgraph RuntimeStage ["Runtime Stage: Distroless / Alpine Non-Root"]
        DropCaps["cap_drop: ALL"]
        ReadOnly["read_only: true (tmpfs: /tmp)"]
        User["USER 10001:10001"]
        Pip --> CopyBin["COPY --from=builder"]
    end
```

