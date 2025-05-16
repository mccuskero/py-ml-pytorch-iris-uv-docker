# Define variables
PROJECT_NAME := python-pytorch-app
COMPOSE_FILE := docker-compose.yml
DOCKER_IMAGE := $(PROJECT_NAME)-image
PROJECT_NAME_MODEL := python-pytorch-app-model
COMPOSE_FILE_MODEL := docker-compose-model.yml

# docker image commands for model training
build-model:
	docker build -t $(PROJECT_NAME_MODEL) -f Dockerfile.model .

train-model:
	docker run --name $(PROJECT_NAME_MODEL) -v /Users/owenmccusker/Documents/dev/python/py-ml-torch/model:/app/model $(PROJECT_NAME_MODEL):latest

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
build:
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

.PHONY: build up down restart logs