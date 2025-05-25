# Define variables
PROJECT_NAME := py-pytorch-clf-api
COMPOSE_FILE := docker-compose.yml
DOCKER_IMAGE := $(PROJECT_NAME)-image
PROJECT_NAME_MODEL := py-pytorch-clf-model
COMPOSE_FILE_MODEL := docker-compose-model.yml

# docker image commands for model training
docker-build-model:
	docker build -t $(PROJECT_NAME_MODEL) -f Dockerfile.model .

docker-train-model:
	docker run --name $(PROJECT_NAME_MODEL) -v ./data/model:/app/data/model $(PROJECT_NAME_MODEL):latest

rm-model:
	docker rm $(PROJECT_NAME_MODEL)

shell-model:
	docker run -it --rm $(PROJECT_NAME_MODEL):latest /bin/bash

# Docker compose commands for model training
up-model:
	docker-compose -f $(COMPOSE_FILE_MODEL) up -d

down-model:
	docker-compose -f $(COMPOSE_FILE_MODEL) down

# Dockerfile commands a new image with the build	
docker-build:
	docker build -t $(PROJECT_NAME):latest .

run:
	docker run --name $(PROJECT_NAME) -p 8000:8000 $(PROJECT_NAME):latest

rm:
	docker rm $(PROJECT_NAME)

stop:
	docker stop $(PROJECT_NAME)

shell:
	docker run -it --rm $(PROJECT_NAME):latest /bin/bash

attach:
	docker exec -it $(PROJECT_NAME) /bin/bash

# docker compose commands
up-classifier:
	docker-compose -f $(COMPOSE_FILE) up -d

down-classifier:
	docker-compose -f $(COMPOSE_FILE) down

restart-classifier: down-classifier up-classifier

logs-classifier:
	docker-compose -f $(COMPOSE_FILE) logs -f

# clean up all the docker images and containers
# if you get errors about disk beging full, try this, clean-all, and/or clean-images
clean:
	@rm -f docker-build*

clean-all:
	@make clean
	@make clean-images

clean-images:
	@docker system prune -a --filter label=project-name="$(PROJECT_NAME)" -f

.PHONY: build up down restart logs