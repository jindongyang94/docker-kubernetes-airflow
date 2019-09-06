
# There is a need to reformat this properly to get the it automated.
# 1: tag it incrementally
# 2: automatically find the docker image with the latest built tag
# 3: push the correct tag into the hubble docker repo
# DO NOT USE THIS FILE YET. IT IS NOT COMPLETE.

docker build --rm -t hubble/docker-airflow:latest .
docker tag $(shell docker images hubble/docker-airflow:latest) 175416825336.dkr.ecr.ap-southeast-1.amazonaws.com/airflow:1.01.2
docker push 175416825336.dkr.ecr.ap-southeast-1.amazonaws.com/airflow:1.01.2