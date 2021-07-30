#!/bin/bash
ROOT_DIR=$(pwd)
VOLUMES_DIR=${ROOT_DIR}/volumes

if [ -d "$VOLUMES_DIR" ]; then
  echo "the $VOLUMES_DIR already exists"
else
  mkdir $VOLUMES_DIR
  echo "$VOLUMES_DIR directory has been created."
fi

POSTGRES_DIR=${VOLUMES_DIR}/postgres_data

if [ -d "$POSTGRES_DIR" ]; then
  echo "The $POSTGRES_DIR already exists"
else
  mkdir $POSTGRES_DIR
fi

PGADMIN_DIR=${VOLUMES_DIR}/pgadmin_data

if [ -d "$PGADMIN_DIR" ]; then
  echo "The $PGADMIN_DIR already exists"
else
  mkdir $PGADMIN_DIR
fi

ODOO_CONFIG_DIR=${VOLUMES_DIR}/odoo_config

if [ -d "$ODOO_CONFIG_DIR" ]; then
  echo "The $ODOO_CONFIG_DIR already exists"
else
  mkdir $ODOO_CONFIG_DIR
fi

ODOO_DATA_DIR=${VOLUMES_DIR}/odoo_data

if [ -d "$ODOO_DATA_DIR" ]; then
  echo "The $ODOO_DATA_DIR already exists"
else
  mkdir $ODOO_DATA_DIR
fi

ODOO_CORE_DIR=${VOLUMES_DIR}/odoo_core

if [ -d "$ODOO_CORE_DIR" ]; then

  echo "The $ODOO_CORE_DIR already exists"
else
  mkdir $ODOO_CORE_DIR
fi

docker volume create --driver local --opt type=none --opt device=$POSTGRES_DIR --opt o=bind postgres_data
docker volume create --driver local --opt type=none --opt device=$PGADMIN_DIR --opt o=bind pgadmin_data
docker volume create --driver local --opt type=none --opt device=$ODOO_CONFIG_DIR --opt o=bind odoo_config
docker volume create --driver local --opt type=none --opt device=$ODOO_DATA_DIR --opt o=bind odoo_data
docker volume create --driver local --opt type=none --opt device=$ODOO_CORE_DIR --opt o=bind odoo_core
