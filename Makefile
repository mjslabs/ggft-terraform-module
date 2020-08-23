ifneq (,)
.error This Makefile requires GNU Make.
endif

CURRENT_DIR     = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all: fmt lint docs

.PHONY: docs
docs:
	@if docker run --rm \
		-v $(CURRENT_DIR):/data \
		cytopia/terraform-docs:latest \
		terraform-docs-replace md README.md; then \
		echo "OK"; \
	else \
		echo "Failed"; \
		exit 1; \
	fi; 

.PHONY: fmt
fmt:
	@terraform fmt

.PHONY: format
format: fmt

.PHONY: lint
lint:
	@docker run --rm -v $(CURRENT_DIR):/data -t wata727/tflint

.gitignore:
	@curl -o .gitignore  'https://www.toptal.com/developers/gitignore/api/terraform,visualstudiocode,jetbrains+all,vim,macos,linux,windows'
