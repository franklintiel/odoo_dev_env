#!/bin/bash
ROOT_DIR=$(pwd)

# $ ./script.sh start (start docker containers)
# $ ./script.sh stop (stop docker containers)
# $ ./script.sh restart (restart docker containers)
# $ ./script.sh access <container_name> (acces inside container selected)
# $ ./script.sh remove_volumes (remove all docker volumes)
# $ ./script.sh add_volumes (build, add and update the docker volumes)

COMMAND=$1
CONTAINER_NAME=$2

function startContainers() {
  echo "Starting the containers..."
  docker image prune
  docker-compose up -d --build
  echo "The containers have been started...DONE!"
}

function stopContainers() {
  echo "Stopping the containers..."
  docker-compose down
  echo "The containers have been stopped."
}

function accessContainer() {
  echo "Accessing to container $CONTAINER_NAME..."
  docker exec -it $CONTAINER_NAME sh
}

function removeContainerVolumes() {
  echo "Removing The docker volumes..."
  docker volume rm odoo_config odoo_data odoo_core postgres_data pgadmin_data
  echo "Remove dawling volumes..."
  docker volume prune
  echo "The docker volumes have been removed!"
}

function addContainerVolumes() {
  echo "Adding the docker volumes..."
  ./volumes_creator.sh
  echo "The docker volumes have been created!"
}


if [ "$COMMAND" == "start" ]; then
  startContainers
elif [ "$COMMAND" == "stop" ]; then
  stopContainers
elif [ "$COMMAND" == "restart" ]; then
  stopContainers
  startContainers
elif [ "$COMMAND" == "access" ]; then
  if [ -z "$CONTAINER_NAME" ]; then
    echo "ERROR: The container name is required"
  else
    accessContainer
  fi
elif [ "$COMMAND" == "remove_volumes" ]; then
  removeContainerVolumes
elif [ "$COMMAND" == "add_volumes" ]; then
  addContainerVolumes
fi

