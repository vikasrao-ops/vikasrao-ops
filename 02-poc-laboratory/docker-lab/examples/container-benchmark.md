# Container Image Size & CVE Attack Surface Benchmark

| Base Image Paradigm | Final Image Size | Package Manager Present | Shell Present | Vulnerability Count (Trivy) |
| :--- | :--- | :--- | :--- | :--- |
| **Standard Debian (`python:3.12`)** | ~1,020 MB | `apt` (Active) | `/bin/bash`, `/bin/sh` | ~45-80 CVEs |
| **Slim Debian (`python:3.12-slim`)** | ~160 MB | `apt` (Active) | `/bin/sh` | ~10-25 CVEs |
| **Alpine Multi-Stage (`python:3.12-alpine`)** | ~48 MB | `apk` (Builder only) | `/bin/sh` | ~0-2 CVEs |
| **Distroless (`gcr.io/distroless/python3`)** | ~28 MB | **None** | **None** | **0 CVEs** |

