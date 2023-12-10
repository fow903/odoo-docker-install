# [Odoo](https://www.odoo.com "Odoo's Homepage") Install Script
## Installation procedure

##### 1. Download the script:
```
sudo wget https://raw.githubusercontent.com/fow903/odoo-docker-install/14.0/odoo_install.sh
```
##### 2. Modify the parameters as you wish.
There are a few things you can configure, this is the most used list:<br/>
```OE_USER``` will be the username for the system user.<br/>
```ODOO_VERSION``` is the Odoo version to install, for example ```14.0``` for Odoo V14.<br/>
```POSTGRES_VERSION``` is the Postgres version to install, for example ```15``` for Postgres V15.<br/>
#### 3. Make the script executable
```
sudo chmod +x odoo_install.sh
```
##### 4. Execute the script:
```
sudo ./odoo_install.sh
```