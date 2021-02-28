# terraform-boilerplate

- set AWS credential
```shell
$ cp .envrc.example .envrc
$ direnv allow
direnv: loading /path/terraform-boilerplate/to/.envrc
direnv: export +AWS_ACCESS_KEY_ID +AWS_DEFAULT_REGION +AWS_SECRET_ACCESS_KEY

$ aws sts get-caller-identity --query Account --output text
xxxxxxxxxxxx
```

- set .terraformrc
```shell
$ cp .terraformrc.example .terraformrc
```

- set githooks
```shell
$ git config core.hooksPath .githooks
$ chmod a+x .githooks/pre-commit
```
