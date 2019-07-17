function db-login() {
  # Function will open a psql shell connected to the DB used by the specified service
  # Usage: db-login dev auth-service

  local env=$1
  local service=$2

  local result=$(get-ssm-params -path /${env}/${service} | jq)

  local DB_HOST=$(echo ${result} | jq -r .DB_HOST)
  local DB_USER=$(echo ${result} | jq -r .DB_USER)
  local DB_PASSWORD=$(echo ${result} | jq -r .DB_PASSWORD)
  local DB_PORT=$(echo ${result} | jq -r .DB_PORT)
  local DB_NAME=$(echo ${result} | jq -r .DB_NAME)

  if [[ "${DB_PORT}" = "null" ]]
  then
        DB_PORT=5432
  fi

  if [[ "${DB_NAME}" = "null" ]]
  then
        DB_NAME=$(echo ${service} | tr - _)
  fi

  #  echo "PGHOST=${DB_HOST} PGUSER=${DB_USER} PGPASSWORD=${DB_PASSWORD} PGPORT=${DB_PORT} psql -d ${DB_NAME}"

  PGHOST=${DB_HOST} PGUSER=${DB_USER} PGPASSWORD=${DB_PASSWORD} psql -d ${DB_NAME}
}

function db-copy-remote() {
  local env=$1
  local service=$2

  local result=$(get-ssm-params -path /${env}/${service} | jq)

  local DB_HOST=$(echo ${result} | jq -r .DB_HOST)
  local DB_USER=$(echo ${result} | jq -r .DB_USER)
  local DB_PASSWORD=$(echo ${result} | jq -r .DB_PASSWORD)
  local DB_PORT=$(echo ${result} | jq -r .DB_PORT)
  local DB_NAME=$(echo ${result} | jq -r .DB_NAME)

  if [[ "${DB_PORT}" = "null" ]]
  then
        DB_PORT=5432
  fi

  if [[ "${DB_NAME}" = "null" ]]
  then
        DB_NAME=$(echo ${service} | tr - _)
  fi

  echo "Creating Local Database: ${DB_NAME}"
  psql postgres -c "CREATE DATABASE ${DB_NAME}"

  DUMP_FILE=./${env}_${DB_NAME}.dump

  echo "Copying Database ${DB_NAME} from ${env}..."
  echo "\n PGPASSWORD=${DB_PASSWORD} pg_dump -Fc -v -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} > ${DUMP_FILE}\n"
  PGPASSWORD=${DB_PASSWORD} pg_dump -Fc -v -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} > ${DUMP_FILE}

  echo "\n pg_restore -v -h localhost -U $(whoami) -d ${DB_NAME} --no-acl ${DUMP_FILE} \n"
  pg_restore -v -h localhost -U $(whoami) -d ${DB_NAME} --no-acl ${DUMP_FILE}

  echo "\n Dump file saved to ${DUMP_FILE}"
#  rm ${DUMP_FILE}

  echo "Done."
}

function db-copy-remote-data-table() {
  local env=$1
  local service=$2
  local TABLE=$3

  local result=$(get-ssm-params -path /${env}/${service} | jq)

  local DB_HOST=$(echo ${result} | jq -r .DB_HOST)
  local DB_USER=$(echo ${result} | jq -r .DB_USER)
  local DB_PASSWORD=$(echo ${result} | jq -r .DB_PASSWORD)
  local DB_PORT=$(echo ${result} | jq -r .DB_PORT)
  local DB_NAME=$(echo ${result} | jq -r .DB_NAME)

  if [[ "${DB_PORT}" = "null" ]]
  then
        DB_PORT=5432
  fi

  if [[ "${DB_NAME}" = "null" ]]
  then
        DB_NAME=$(echo ${service} | tr - _)
  fi

  echo "Creating Local Database: ${DB_NAME}"
  psql postgres -c "CREATE DATABASE ${DB_NAME}"

  DUMP_FILE=./${env}_${DB_NAME}_${TABLE}.dump

  echo "Copying Database ${DB_NAME} from ${env}..."
  echo "\n PGPASSWORD=${DB_PASSWORD} pg_dump -Fc -v -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} > ${DUMP_FILE}\n"
  PGPASSWORD=${DB_PASSWORD} pg_dump -Fc -v -h ${DB_HOST} -U ${DB_USER} --column-inserts --data-only --table=${TABLE} ${DB_NAME} > ${DUMP_FILE}

  echo "\n Dump file saved to ${DUMP_FILE}"
#  rm ${DUMP_FILE}

  echo "Done."
}

function db-restore-remote() {
  local env=$1
  local service=$2
  local DUMP_FILE=$3

  local result=$(get-ssm-params -path /${env}/${service} | jq)

  local DB_HOST=$(echo ${result} | jq -r .DB_HOST)
  local DB_USER=$(echo ${result} | jq -r .DB_USER)
  local DB_PASSWORD=$(echo ${result} | jq -r .DB_PASSWORD)
  local DB_PORT=$(echo ${result} | jq -r .DB_PORT)
  local DB_NAME=$(echo ${result} | jq -r .DB_NAME)

  if [[ "${DB_PORT}" = "null" ]]
  then
        DB_PORT=5432
  fi

  if [[ "${DB_NAME}" = "null" ]]
  then
        DB_NAME=$(echo ${service} | tr - _)
  fi

  echo "Run command below to restoring Database ${DB_NAME} to ${env}..."

  echo "\nPGPASSWORD=${DB_PASSWORD} pg_restore -v -h ${DB_HOST} -U ${DB_USER} -d ${DB_NAME} --no-acl ${DUMP_FILE}\n"

  echo "Done."
}

