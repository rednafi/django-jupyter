path := .

define Comment
	- Run `make help` to see all the available options.
	- Run `make lint` to run the linter.
	- Run `make lint-check` to check linter conformity.
	- Run `dep-lock` to lock the deps in 'requirements.txt' and 'requirements-dev.txt'.
	- Run `dep-sync` to sync current environment up to date with the locked deps.
endef


.PHONY: lint
lint: black ruff	## Apply all the linters.


.PHONY: lint-check
lint-check:  ## Check whether the codebase satisfies the linter rules.
	@echo
	@echo "Checking linter rules..."
	@echo "========================"
	@echo
	@black --check $(path)
	@ruff $(path)


.PHONY: black
black: ## Apply black.
	@echo
	@echo "Applying black..."
	@echo "================="
	@echo
	@docker compose exec debug black --fast $(path)
	@echo


.PHONY: ruff
ruff: ## Apply ruff.
	@echo "Applying ruff..."
	@echo "================"
	@echo
	@docker compose exec debug ruff --fix $(path)


.PHONY: help
help: ## Show this help message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


.PHONY: test
test: ## Run the tests against the current version of Python.
	pytest -v -s


.PHONY: dep-lock
dep-lock: ## Freeze deps in 'requirements.txt' file.
	@docker compose exec debug \
		pip-compile requirements.in -o requirements.txt --no-emit-options
	@docker compose exec debug \
		pip-compile requirements-dev.in -o requirements-dev.txt --no-emit-options


.PHONY: migrate
migrate: ## Run Django migrations.
	@docker compose exec debug python mysite/manage.py makemigrations
	@docker compose exec debug python mysite/manage.py migrate

	# Db permission.
	@docker compose exec debug chown -R root:root /code/mysite/db.sqlite3


.PHONY: rebuild
rebuild:
	@docker compose build --no-cache

.PHONY: up
up:
	@docker compose up -d

.PHONY: down
down:
	@docker compose down -t 1

.PHONY: debug
debug:
	@docker compose exec debug bash
