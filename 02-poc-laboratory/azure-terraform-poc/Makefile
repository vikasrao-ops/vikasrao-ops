.PHONY: init plan apply destroy fmt

TF_DIR := infrastructure

init:
	cd $(TF_DIR) && terraform init

plan:
	cd $(TF_DIR) && terraform plan

apply:
	cd $(TF_DIR) && terraform apply -auto-approve

destroy:
	cd $(TF_DIR) && terraform destroy -auto-approve

fmt:
	cd $(TF_DIR) && terraform fmt -recursive

