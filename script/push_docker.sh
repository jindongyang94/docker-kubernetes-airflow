
# There is a need to reformat this properly to get the it automated.
# 1: tag it incrementally
# 2: automatically find the docker image with the latest built tag
# 3: push the correct tag into the hubble docker repo

# Local Tags
AIRFLOW_LOCAL_DOCKER='hubble/docker-airflow'
AIRFLOW_LOCAL_TAG='latest'

# AWS Tags
AIRFLOW_ECR_DOCKER='175416825336.dkr.ecr.ap-southeast-1.amazonaws.com/airflow'
AIRFLOW_CURRENT_ECR_TAG=\
$(aws ecr describe-images --output json --repository-name airflow \
--query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags[0]' | jq . --raw-output)
AIRFLOW_NEXT_ECR_TAG=\
$(echo $AIRFLOW_CURRENT_ECR_TAG | awk -F. -v OFS=. 'NF==1{print ++$NF}; \
NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}')

echo "ECR Docker to push to: $AIRFLOW_ECR_DOCKER"
echo "ECR Tag currently on: $AIRFLOW_CURRENT_ECR_TAG"
echo "ECR Tag going next: $AIRFLOW_NEXT_ECR_TAG"
echo "\n"

case "$1" in
    next)
        echo "Building Next Tag: $AIRFLOW_ECR_DOCKER:$AIRFLOW_NEXT_ECR_TAG"
        docker build --rm -t ${AIRFLOW_LOCAL_DOCKER}:${AIRFLOW_LOCAL_TAG} .
        $(aws ecr get-login --no-include-email --region ap-southeast-1)
        docker tag hubble/docker-airflow:latest ${AIRFLOW_ECR_DOCKER}:${AIRFLOW_NEXT_ECR_TAG}
        docker push ${AIRFLOW_ECR_DOCKER}:${AIRFLOW_NEXT_ECR_TAG}
        ;;
    current)
        echo "Building Current Tag: $AIRFLOW_ECR_DOCKER:$AIRFLOW_CURRENT_ECR_TAG"
        docker build --rm -t ${AIRFLOW_LOCAL_DOCKER}:${AIRFLOW_LOCAL_TAG} .
        $(aws ecr get-login --no-include-email --region ap-southeast-1)
        docker tag hubble/docker-airflow:latest ${AIRFLOW_ECR_DOCKER}:${AIRFLOW_CURRENT_ECR_TAG}
        aws ecr batch-delete-image --repository-name ${AIRFLOW_ECR_DOCKER} --image-ids imageTag=${AIRFLOW_CURRENT_ECR_TAG}
        docker push ${AIRFLOW_ECR_DOCKER}:${AIRFLOW_CURRENT_ECR_TAG}
        ;;
esac