OE_USER="odoo"
OE_HOME="/$OE_USER"
POSTGRES_USER=$OE_USER
POSTGRES_PASSWORD="postgres"
POSTGRES_CONTAINER_NAME="db"
ODOO_CONTAINER_NAME="odoo"
ODOO_VERSION="13.0"
POSTGRES_VERSION="15"

echo -e "\n---- Create ODOO system user ----"
sudo adduser --system --quiet --shell=/bin/bash --home=$OE_HOME --gecos 'ODOO' --group $OE_USER

sudo adduser $OE_USER sudo

echo -e "\n---- Create Posgres data folder ----"

DATA_PATH="/$OE_HOME/.data"
sudo mkdir $DATA_PATH

echo -e "\n---- Create Posgres container ----"

docker run -d \
	--name $POSTGRES_CONTAINER_NAME \
	-e POSTGRES_USER=$POSTGRES_USER \
	-e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    -e POSTGRES_DB=postgres \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-v $DATA_PATH:/var/lib/postgresql/data \
	postgres:$POSTGRES_VERSION

echo -e "\n---- Create Log directory ----"
LOG_PATH="/var/log/$OE_USER"
sudo mkdir $LOG_PATH
sudo chown $OE_USER:$OE_USER $LOG_PATH

sudo chown 101 $FILESTORE_DIR

echo -e "\n---- Create Config directory ----"

CONFIG_PATH="/$OE_HOME/config"
sudo mkdir $CONFIG_PATH

echo -e "\n---- Create Addons directory ----"

ADDONS_DIR="/$OE_HOME/extra-addons"
sudo mkdir $ADDONS_DIR

echo -e "\n---- Create Filestore directory ----"

FILESTORE_DIR="/$OE_HOME/OdooData"
sudo mkdir $FILESTORE_DIR

sudo chown 101 $FILESTORE_DIR

echo -e "\n---- Create Odoo container ----"

docker run -d \
    -p 8069:8069 -p 8072:8072 \
    -v $CONFIG_PATH:/etc/odoo \
    -v $ADDONS_DIR:/mnt/extra-addons \
    -v $LOG_PATH:/var/log/odoo \
    -v $FILESTORE_DIR:/var/lib/odoo \
    --name $ODOO_CONTAINER_NAME \
    --link $POSTGRES_CONTAINER_NAME:$POSTGRES_CONTAINER_NAME \
    -t odoo:$ODOO_VERSION