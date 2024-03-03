function dockerRMExited() {
  docker rm $(docker ps -a | grep "Exited" | awk '{print $1}')
}

function dockerRMI() {
  docker rmi -f $(docker images | grep "<none>" | awk '{print $3}')
}

function dockerLoginECR() {
  ACCOUNT=$(aws sts get-caller-identity --query 'Account' --output text)
  REGION=$(aws configure get region)
  aws ecr get-login-password | docker login --username AWS --password-stdin ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com
}

function dockerRehostImage() {
  ACCOUNT=$(aws sts get-caller-identity --query 'Account' --output text)
  REGION=$(aws configure get region)
# aws-rehost-docker-image
#
# pulls a public docker hub image and 'rehosts' it on ECR with the same name and tag of the public image
#
#   $1 - docker hub public image
#   $2 - docker hub tag
#
# Examples:
#
#   dockerRehostImage tryretool/backend 2.68.81
#
# Dependencies:
#
#   - docker
#   - aws cli

IMAGE=${1}
TAG=${2}

# 2.66.81

# Pull public image from dockerhub
docker pull ${IMAGE}:${TAG}

# Create repo if not exists
aws ecr create-repository --repository-name ${IMAGE} || true

# Login to ecr
aws ecr get-login-password | docker login --username AWS --password-stdin ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com

ECR_REPO_URI="${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${IMAGE}"

# Tag image
docker image tag ${IMAGE}:${TAG} ${ECR_REPO_URI}:${TAG}

# Push to ECR
echo "Pushing to ECR...${ECR_REPO_URI}:${TAG}"
docker push ${ECR_REPO_URI}:${TAG}
}