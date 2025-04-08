#!/bin/bash

command="$1"

if [ -z "$command" ]; then
    command="start"
fi

ProjectRoot="$(dirname "$(realpath "$0")")/.."

export AMBULANCE_API_ENVIRONMENT="Development"
export AMBULANCE_API_PORT="8080"
export AMBULANCE_API_MONGODB_USERNAME="root"
export AMBULANCE_API_MONGODB_PASSWORD="neUhaDnes"

mongo() {
    docker compose --file "$ProjectRoot/deployments/docker-compose/compose.yaml" "$@"
}

case "$command" in
    "openapi")
        docker run --rm -ti -v "$ProjectRoot:/local" openapitools/openapi-generator-cli generate -c /local/scripts/generator-cfg.yaml
        ;;
    "start")
        {
            mongo up --detach
            go run "$ProjectRoot/cmd/ambulance-api-service"
        } || {
            mongo down
        }
        ;;
    "test")
        go test -v ./...
        ;;
    "mongo")
        mongo up
        ;;
    "docker")
        docker build -t pprizbul/ambulance-wl-webapi:local-build -f ${ProjectRoot}/build/docker/Dockerfile .
        ;;
    *)
        echo "Unknown command: $command" >&2
        exit 1
        ;;
esac