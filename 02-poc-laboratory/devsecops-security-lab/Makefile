.PHONY: scan-secrets scan-sast scan-trivy test-all

scan-secrets:
	gitleaks detect --config .gitleaks.toml --verbose

scan-sast:
	semgrep --config rules/custom-semgrep-rules.yml examples/

scan-trivy:
	trivy config --config trivy.yaml .

test-all: scan-secrets scan-sast scan-trivy

