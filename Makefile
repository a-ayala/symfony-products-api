DOCKER_COMPOSE = docker-compose

# Containers
CONTAINER_PHP = $(DOCKER_COMPOSE) exec php

# PHP Container Executables
PHP      = $(CONTAINER_PHP) php
COMPOSER = $(CONTAINER_PHP) composer
SYMFONY  = $(CONTAINER_PHP) bin/console

# Other
.DEFAULT_GOAL = help
.PHONY        = help build up start down logs sh composer vendor sf cc

## — ❓
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## — Docker 🐳
build: ## Builds the Docker images
	@$(DOCKER_COMPOSE) build --pull --no-cache

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMPOSE) up --detach

start: build up ## Build and start the containers

down: ## Stop the docker hub
	@$(DOCKER_COMPOSE) down --remove-orphans

logs: ## Show live logs
	@$(DOCKER_COMPOSE) logs --tail=0 --follow

sh: ## Connect to the PHP-FPM container
	@$(CONTAINER_PHP) sh

## — Composer 🧙
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --prefer-dist --no-progress --no-scripts --no-interaction
vendor: composer

vendor-no-dev: ## Install vendors according to the current composer.lock file
vendor-no-dev: c=install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction
vendor-no-dev: composer

## — Symfony 🎵
sf: ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
	@$(eval c ?=)
	@$(SYMFONY) $(c)

cc: c=c:c ## Clear the cache
cc: sf