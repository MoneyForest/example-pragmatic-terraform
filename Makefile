.PHONY: init
init:
	terraform init

.PHONY: fmt
fmt:
	terraform fmt -recursive
