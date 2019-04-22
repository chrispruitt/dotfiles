function get-lambda-versions() {
  local FILTER_ENV=^${1}-
  local results=$(aws lambda list-functions | jq '.Functions | sort_by(.FunctionName)')

  echo ${1}
  for row in $(echo "${results}" | jq -r --arg FILTER_ENV "$FILTER_ENV" '.[] | {FunctionName} | select(.FunctionName | match($FILTER_ENV;"i")) | @base64'); do

    local func_name=$(echo ${row} | base64 --decode | jq -r '.FunctionName')


    IFS='-' read -r env name <<< "$func_name"
    local version=$(get-ssm-params -path /${env}/lambda/${name} | jq -r '.VERSION')

    echo ${name} - ${version}
  done
}

function aws-ssh() {
  local IP=$1
  local REGION=$(aws configure get region)
  local PROVISIONER=$(if [[ "${REGION}" == "us-gov-west-1" ]]; then echo "groot_provisioner.pem"; else echo "root_provisioner.pem"; fi)

  echo "ssh ec2-user@${IP} -i ~/.ssh/${PROVISIONER}"
  ssh ec2-user@${IP} -i ~/.ssh/${PROVISIONER}
}

#function aws-get-security-groups() {
#  local FILTER_NAME=$1
#
#  local result=$(aws ec2 describe-security-groups | jq -r '.SecurityGroups[] | {GroupId} + {GroupName} + {Description}')
#
#  if [[ ! -z "$FILTER_NAME" ]]
#  then
#    result=$(echo ${result} | jq -r --arg FILTER_NAME "$FILTER_NAME" 'select(.GroupName | match($FILTER_NAME;"i"))')
#  fi
#
#  echo ${result} | jq
#}

function aws-ssh-generate-configs() {
  # Doesn't work for gov cloud.......................
  # Will need to write my own maybe..................if i care that much. lets see how much i use it
  local REGION=$(aws configure get region)
  python3 ~/random-tools/aws-ssh-config/aws-ssh-config.py --white-list-region ${REGION} --private --prefix ${AWS_PROFILE}- > ~/.ssh/config
}

function aws-describe-instances-by-service() {
  local CLUSTER=$1
  local TASK_NAME=$2

  local TASK_LIST=$(aws ecs list-tasks --cluster ${CLUSTER} --desired-status RUNNING --service-name ${TASK_NAME})
  local TASK_ARN=$(echo ${TASK_LIST} | jq -r '.taskArns[0]')

  if [[ -z "$TASK_ARN" ]] || [[ "$TASK_ARN" = 'null' ]]
  then
    echo "No running task found for ${TASK_NAME} in ${CLUSTER}"
  fi

  local NUMBER_OF_TASKS=$(echo ${TASK_LIST} | jq length)
  if (( $NUMBER_OF_TASKS > 1 ))
  then
    echo Found: ${NUMBER_OF_TASKS} tasks running. Will use first task to locate one ec2 IP.
  fi


  local CONTAINER_INSTANCE_ARN=$(aws ecs describe-tasks \
    --cluster ${CLUSTER} \
    --tasks ${TASK_ARN} \
    | jq -r '.tasks[0].containerInstanceArn')

  if [[ -z "$CONTAINER_INSTANCE_ARN" ]]
  then
    echo "No container instance found for task: ${TASK_ARN}"
    return
  fi

  local EC2_INSTANCE_ID=$(aws ecs describe-container-instances \
    --cluster ${CLUSTER} \
    --container-instances ${CONTAINER_INSTANCE_ARN} \
    | jq -r '.containerInstances[0].ec2InstanceId')

  if [[ -z "$EC2_INSTANCE_ID" ]]
  then
    echo "No ec2 instance found for container: ${CONTAINER_INSTANCE_ARN}"
    return
  fi

  aws ec2 describe-instances --instance-ids ${EC2_INSTANCE_ID} | jq -r '.Reservations[].Instances[] | {PublicIpAddress} + {PrivateIpAddress} + (.Tags|from_entries) + {KeyName}'
}

function aws-logs() {
  echo You should probably just use 'saw'
  local CLUSTER=$1
  local SERVICE_NAME=$2
  local STREAM=/${CLUSTER}/ecs/${SERVICE_NAME}

  if [[ -z "$3" ]]
  then
    echo executing: "saw watch ${STREAM}\n\n"
    saw watch ${STREAM}
   else
    echo executing: "saw get ${STREAM} --start $3\n\n"
    saw get ${STREAM} --start $3
  fi

}

function aws-describe-instances() {
  # USAGE ############################################
  # aws-describe-instances #lists all ecs instances with IP and tags
  # aws-describe-instances <matchEnv> <searchforStringInName>
  ####################################################

  local FILTER_ENV=$1
  local FILTER_NAME=$2
  local result=$(aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | {PublicIpAddress} + {PrivateIpAddress} + (.Tags|from_entries) + {KeyName}')

  if [[ ! -z "$FILTER_ENV" ]]
  then
    result=$(echo ${result} | jq -r --arg FILTER_ENV "$FILTER_ENV" 'select(.Environment | match($FILTER_ENV;"i"))')
  fi

  if [[ ! -z "$FILTER_NAME" ]]
  then
    result=$(echo ${result} | jq -r --arg FILTER_NAME "$FILTER_NAME" 'select(.Name | match($FILTER_NAME;"i"))')
  fi

  echo ${result} | jq
}



function aws-describe-tasks-by-service() {
  local CLUSTER=$1
  local TASK_NAME=$2

  local TASK_LIST=$(aws ecs list-tasks --cluster ${CLUSTER} --desired-status RUNNING --service-name ${TASK_NAME} | jq -r '.taskArns[]')

  if [[ -z "TASK_LIST" ]] || [[ "TASK_LIST" = 'null' ]]
  then
    echo "No running task found for ${TASK_NAME} in ${CLUSTER}"
  fi


  aws ecs describe-tasks --tasks ${TASK_LIST} --cluster ${CLUSTER} | jq -r '.tasks[] | {taskArn} + {taskDefinitionArn}'
}

function aws-deactivate-mfa-device() {
  local USERNAME=$1
  echo $USERNAME

  local SERIAL_NUMBER=$(aws iam list-mfa-devices --user-name "${USERNAME}" | jq -r '.MFADevices[0].SerialNumber')

  aws iam deactivate-mfa-device --user-name ${USERNAME} --serial-number ${SERIAL_NUMBER}
}