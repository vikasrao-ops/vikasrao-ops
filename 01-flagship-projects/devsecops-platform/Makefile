.PHONY: test lint build scan sbom all

IMAGE_NAME := devsecops-secure-api
TAG := latest

all: test lint build scan sbom

test:
	cd src && python -m unittest test_app.py

lint:
	python -m pip install flake8
	flake8 src --max-line-length=120

build:
	docker build -t $(IMAGE_NAME):$(TAG) src

scan:
	trivy image --severity HIGH,CRITICAL $(IMAGE_NAME):$(TAG)

sbom:
	syft $(IMAGE_NAME):$(TAG) -o spdx-json=sbom.spdx.json

