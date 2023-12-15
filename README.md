# [Odoo](https://www.odoo.com "Odoo's Homepage") Install Script
## Installation procedure

##### 1. Download the script:   

- Debian

```
sudo wget https://raw.githubusercontent.com/fow903/odoo-docker-install/16.0/odoo_install.sh
```

- MacOS Intel Chipset

```
sudo wget https://raw.githubusercontent.com/fow903/odoo-docker-install/16.0/macos_odoo_install_intel.sh
```

- MacOS Arm Chipset

```
sudo wget https://raw.githubusercontent.com/fow903/odoo-docker-install/16.0/macos_odoo_install_arm.sh
```
##### 2. Modify the parameters as you wish.
There are a few things you can configure, this is the most used list:<br/>
```OE_USER``` will be the username for the system user.<br/>
```ODOO_VERSION``` is the Odoo version to install, for example ```16.0``` for Odoo V16.<br/>
```POSTGRES_VERSION``` is the Postgres version to install, for example ```15``` for Postgres V15.<br/>
#### 3. Make the scripts executable

```
sudo chmod +x functions.sh
```

- Debian

```
sudo chmod +x odoo_install.sh
```

- MacOS Intel Chipset

```
sudo chmod +x macos_odoo_install_intel.sh
```

- MacOS Arm Chipset

```
sudo chmod +x macos_odoo_install_arm.sh
```

##### 4. Execute the script:

- Debian

```
./odoo_install.sh
```

- MacOS Intel Chipset

```
./macos_odoo_install_intel.sh
```

- MacOS Arm Chipset

```
./macos_odoo_install_arm.sh
```
