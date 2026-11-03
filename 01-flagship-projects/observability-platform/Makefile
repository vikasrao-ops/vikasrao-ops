.PHONY: up down restart logs lint-config

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose down && docker compose up -d

logs:
	docker compose logs -f

lint-config:
	docker run --rm -v $(PWD)/prometheus:/etc/prometheus prom/prometheus:v2.51.0 promtool check config /etc/prometheus/prometheus.yml
	docker run --rm -v $(PWD)/prometheus:/etc/prometheus prom/prometheus:v2.51.0 promtool check rules /etc/prometheus/alert.rules.yml

