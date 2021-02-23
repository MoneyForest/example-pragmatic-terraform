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

.PHONY: modify-db-password
modify-db-password:
	aws ssm put-parameter --name '/db/password' --type SecureString --value '${PASSWORD}' --overwrite
