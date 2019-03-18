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