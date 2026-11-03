.PHONY: fmt validate init-all

fmt:
	cd infrastructure && terraform fmt -recursive -check

validate:
	cd infrastructure/azure && terraform init -backend=false && terraform validate
	cd infrastructure/aws && terraform init -backend=false && terraform validate
	cd infrastructure/gcp && terraform init -backend=false && terraform validate

init-all:
	cd infrastructure/azure && terraform init
	cd infrastructure/aws && terraform init
	cd infrastructure/gcp && terraform init

