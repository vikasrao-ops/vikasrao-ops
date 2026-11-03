.PHONY: lint template test-dry-run apply-manifests

CHART_DIR := helm
NAMESPACE := platform-workloads

lint:
	helm lint $(CHART_DIR)

template:
	helm template test-release $(CHART_DIR) -f examples/values-production.yaml

test-dry-run:
	helm install test-release $(CHART_DIR) --dry-run --debug

apply-manifests:
	kubectl apply -f manifests/

