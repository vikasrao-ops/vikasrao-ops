.PHONY: build-alpine build-distroless run compose-up compose-down

build-alpine:
	docker build -f src/Dockerfile.alpine -t hardened-app:alpine src

build-distroless:
	docker build -f src/Dockerfile.distroless -t hardened-app:distroless src

compose-up:
	docker compose up -d

compose-down:
	docker compose down

