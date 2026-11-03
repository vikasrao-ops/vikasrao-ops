.PHONY: fmt diff breakdown

fmt:
	cd terraform-before && terraform fmt
	cd terraform-after && terraform fmt

breakdown:
	infracost breakdown --path=terraform-after

diff:
	infracost diff --path=terraform-after --compare-to=terraform-before

