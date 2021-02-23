.PHONY: apply
apply:
	terraform apply

.PHONY: destroy
destroy:
	terraform destroy

.PHONY: fmt
fmt:
	terraform fmt -recursive

.PHONY: init
init:
	terraform init
