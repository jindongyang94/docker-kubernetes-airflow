.PHONY: compose build kill webserver scheduler worker pushcurrent pushnext
build:
	docker build --rm -t hubble/docker-airflow:latest .

compose:
	docker-compose -f docker-compose-CeleryExecutor.yml up -d
	@echo airflow running on http://localhost:8080

kill:
	@echo "Killing all docker-airflow containers"
	docker-compose -f docker-compose-CeleryExecutor.yml down

webserver:
	docker exec -it $(shell docker ps -q --filter label=name=webserver) /entrypoint.sh bash

scheduler:
	docker exec -it $(shell docker ps -q --filter label=name=scheduler) /entrypoint.sh bash

worker:
	docker exec -it $(shell docker ps -q --filter label=name=worker) /entrypoint.sh bash

pushcurrent: build
	sh push_docker.sh current

pushnext: build
	sh push_docker.sh next