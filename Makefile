# User ID
export USER_ID=`id -u`
export GROUP_ID=`id -g`

DOCKERCOMPO = USER_ID=${USER_ID} GROUP_ID=$(GROUP_ID) docker-compose
DOCKERCOMPORUN = $(DOCKERCOMPO) run --rm --service-ports yas
DOCKERNPM = $(DOCKERCOMPORUN) npm

# Help
.SILENT:
.PHONY: help

help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

##########
# Docker #
##########
docker-build:
	@echo "--> Build docker image"
	docker-compose build
docker-up:
	@echo "--> Start docker services"
	$(DOCKERNPM) start
docker-down:
	@echo "--> Stop docker services"
	$(DOCKERCOMPO) down
docker-restart:
	@echo "--> Restart docker services"
	make docker-down
	make docker-up

#######
# NPM #
#######
npm-install:
	@echo "--> Install dependencies"
	$(DOCKERNPM) install
