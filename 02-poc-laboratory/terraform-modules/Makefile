.PHONY: fmt lint

fmt:
	terraform fmt -recursive

lint:
	cd modules/azure-vnet && terraform fmt -check
	cd modules/aws-vpc && terraform fmt -check

