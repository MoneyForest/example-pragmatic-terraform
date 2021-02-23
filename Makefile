.PHONY: apply
apply:
	terraform apply

.PHONY: destroy
destroy:
	terraform destroy

.PHONY: fmt
fmt:
	terraform fmt -recursive

.PHONY: fmt-check
fmt-check:
	terraform fmt -recursive -check

.PHONY: init
init:
	terraform init

.PHONY: validate
validate:
	terraform validate

.PHONY: logs-ecs-example
logs-ecs-example:
	 aws logs filter-log-events --log-group-name /ecs/example

.PHONY: logs-ecs-scheduled-tasks-example
logs-ecs-scheduled-tasks-example:
	 aws logs filter-log-events --log-group-name /ecs-scheduled-tasks/example

.PHONY: modify-db-password
modify-db-password:
	aws ssm put-parameter --name '/db/password' --type SecureString --value '${PASSWORD}' --overwrite

.PHONY: modify-rds-master-user-password
modify-rds-master-password:
	aws rds modify-db-instance --db-instance-identifier 'example' --master-user-password '${PASSWORD}'
