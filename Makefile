OE_USER=odoo
OE_HOME=$(OE_USER)
POSTGRES_USER=$(OE_USER)
POSTGRES_PASSWORD=postgres
POSTGRES_CONTAINER_NAME=db
ODOO_CONTAINER_NAME=odoo
ODOO_VERSION=17.0
POSTGRES_VERSION=15
POSTGRES_PASSWORD=postgres
CONFIG_PATH=/$(OE_HOME)/config
FILESTORE_DIR=/$(OE_HOME)/OdooData
ADDONS_DIR=/$(OE_HOME)/extra-addons
LOG_PATH=/var/log/$(OE_USER)
DATA_PATH=/$(OE_HOME)/.data

.PHONY: pull stop remove update-core run

pull:
	docker pull odoo:${ODOO_VERSION}
stop:
	docker stop $(ODOO_CONTAINER_NAME)

remove: stop
	docker rm $(ODOO_CONTAINER_NAME)

update-core: pull remove run

run:
	docker run -d \
		-p 8069:8069 -p 8072:8072 \
		-v $(CONFIG_PATH):/etc/odoo \
		-v $(ADDONS_DIR):/mnt/extra-addons \
		-v $(LOG_PATH):/var/log/odoo \
		-v $(FILESTORE_DIR):/var/lib/odoo \
		--name $(ODOO_CONTAINER_NAME) \
		--link $(POSTGRES_CONTAINER_NAME):$(POSTGRES_CONTAINER_NAME) \
		-t odoo:$(ODOO_VERSION)