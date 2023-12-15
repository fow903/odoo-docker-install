. ./functions.sh

INSTALL_PATH="$(dirname -- "${BASH_SOURCE[0]}")"
INSTALL_PATH="$(cd -- "$INSTALL_PATH" && pwd)"
if [[ -z "$INSTALL_PATH" ]] ; then
  exit 1
fi
OE_USER="odoo"
OE_HOME="${INSTALL_PATH}"
POSTGRES_USER=$OE_USER
POSTGRES_PASSWORD="postgres"
POSTGRES_CONTAINER_NAME="db"
ODOO_CONTAINER_NAME="odoo"
ODOO_VERSION="16.0"
POSTGRES_VERSION="15"

# Export the default platform for docker build
export DOCKER_DEFAULT_PLATFORM=linux/x86_64 

echo "\n---- Create Postgres data folder ----"

DATA_PATH="/$OE_HOME/.data"
create_directory $DATA_PATH

sudo chown 999 $DATA_PATH

echo "\n---- PostgreSQL data path directory created successfully! ----"

echo "\n---- Create Postgres container ----"

docker run -d \
    --name $POSTGRES_CONTAINER_NAME \
    -e POSTGRES_USER=$POSTGRES_USER \
    -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    -e POSTGRES_DB=postgres \
    -e PGDATA=/var/lib/postgresql/data:z \
    -v $DATA_PATH:/var/lib/postgresql/data \
    --platform linux/x86_64 \
    postgres:$POSTGRES_VERSION

# Check the exit status of the last command (docker run)
if [ $? -ne 0 ]; then
    echo "Error: Failed to run the PostgreSQL container."
    exit 1
fi

echo "\n---- PostgreSQL container created successfully! ----"

echo "\n---- Create Log directory ----"
LOG_PATH="$OE_HOME/log"

create_directory $LOG_PATH

echo "\n---- Create Config directory ----"

CONFIG_PATH="/$OE_HOME/config"
create_directory $CONFIG_PATH

sudo chown 101 $CONFIG_PATH

sudo cp ./default_config.conf $CONFIG_PATH/odoo.conf

echo "\n---- Create Addons directory ----"

ADDONS_DIR="/$OE_HOME/extra-addons"
create_directory $ADDONS_DIR

echo "\n---- Create Odoo container ----"

docker run -d \
    -p 8069:8069 -p 8072:8072 \
    -v $CONFIG_PATH:/etc/odoo \
    -v $ADDONS_DIR:/mnt/extra-addons \
    -v $LOG_PATH:/var/log/odoo \
    -v odoo-web-data:/var/lib/odoo \
    --name $ODOO_CONTAINER_NAME \
    --link $POSTGRES_CONTAINER_NAME:$POSTGRES_CONTAINER_NAME \
    -t odoo:$ODOO_VERSION

# Check the exit status of the last command (docker run)
if [ $? -ne 0 ]; then
    echo "Error: Failed to run the Odoo container."
    exit 1
fi


