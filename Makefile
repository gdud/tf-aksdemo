validate:
	@echo "## Validate terraform configuration ##"
	terraform init -backend=false
	terraform validate
	terraform fmt -check -diff -recursive
	tflint --init
	tflint -c .tflint.hcl
	tfsec --config-file tfsec.yaml

install_tflint:
	@echo "## Install tflint ##"
	curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
	tflint -v

install_tfsec:
	@echo "## Install tfsec ##"
	curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash
	tfsec -v
