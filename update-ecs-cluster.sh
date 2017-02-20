#!/bin/bash
SERVICE_NAME="simple-webapp"
#BUILD_NUMBER=37
IMAGE_VERSION="v_"${BUILD_NUMBER}
TASK_FAMILY="simple-web-app-task"

# Create a new task definition for this build
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" ${TASK_FAMILY}.json > ${TASK_FAMILY}-v_${BUILD_NUMBER}.json

~/.local/bin/aws ecs register-task-definition --family ${TASK_FAMILY} --cli-input-json file://${TASK_FAMILY}-v_${BUILD_NUMBER}.json

# Update the service with the new task definition and desired count
TASK_REVISION=`~/.local/bin/aws ecs describe-task-definition --task-definition ${TASK_FAMILY} | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`

DESIRED_COUNT=`~/.local/bin/aws ecs describe-services --services ${SERVICE_NAME} | egrep "desiredCount" | head -1 | tr "/" " " | awk '{print $2}' | sed 's/,$//'`

if [ ${DESIRED_COUNT} = "0" ]; then
    DESIRED_COUNT="1"
fi

~/.local/bin/aws ecs update-service --cluster default --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count ${DESIRED_COUNT}
