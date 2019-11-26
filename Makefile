.PHONY: compose build kill webserver scheduler worker pushcurrent pushnext

# Build Docker Image Locally
build:
	docker build --rm -t hubble/docker-airflow:latest .

# Set up Local Docker Containers
compose:
	docker-compose -f docker-compose-CeleryExecutor.yml up -d
	@echo airflow running on http://localhost:8080

# Kill Local Docker Containers
kill:
	@echo "Killing all docker-airflow containers"
	docker-compose -f docker-compose-CeleryExecutor.yml down

# Enter Webserver Docker Container as Bash
webserver:
	docker exec -it $(shell docker ps -q --filter label=name=webserver) /entrypoint.sh bash

# Enter Scheduler Docker Container as Bash
scheduler:
	docker exec -it $(shell docker ps -q --filter label=name=scheduler) /entrypoint.sh bash

# Enter Worker Docker Container as Bash
worker:
	docker exec -it $(shell docker ps -q --filter label=name=worker) /entrypoint.sh bash

# Check what Docker Tag No. it is currently in AWS ECR Docker Repository
tag:
	sh script/push_docker.sh

git:
	sh script/push_docker.sh git

# Push Current Local Docker Image to SAME Tag to AWS ECR Docker Repository
pushcurrent: build
	sh script/push_docker.sh current
	
# Push Current Local Docker Image to NEXT Tag to AWS ECR Docker Repository
pushnext: build
	sh script/push_docker.sh next