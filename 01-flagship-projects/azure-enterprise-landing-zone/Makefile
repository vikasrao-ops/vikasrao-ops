.PHONY: init validate plan apply destroy fmt checkov

TF_DIR := infrastructure

init:
	cd $(TF_DIR) && terraform init

validate:
	cd $(TF_DIR) && terraform validate

fmt:
	cd $(TF_DIR) && terraform fmt -recursive -check

plan:
	cd $(TF_DIR) && terraform plan -var-file="../examples/terraform.tfvars.example"

apply:
	cd $(TF_DIR) && terraform apply -var-file="../examples/terraform.tfvars.example" -auto-approve

destroy:
	cd $(TF_DIR) && terraform destroy -var-file="../examples/terraform.tfvars.example" -auto-approve

checkov:
	checkov -d $(TF_DIR) --framework terraform

