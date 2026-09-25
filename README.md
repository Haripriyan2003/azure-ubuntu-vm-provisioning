# Azure Ubuntu VM Provisioning

A Bash-based server provisioning script for quickly setting up a fresh **Ubuntu Linux virtual machine on Microsoft Azure** with commonly required components for Node.js application hosting.

This project automates the installation and basic service configuration of:

* Node.js 24.x
* npm
* Nginx
* MySQL Server
* PM2
* curl
* CA certificates

The script is designed for **DevOps, Cloud, and Infrastructure-as-Code learning and automation**.

---

## Author

**Hari Priyan**
DevOps Engineer

---

## Purpose

When creating a new Ubuntu VM in Azure, several software components are commonly required before deploying a Node.js application.

Instead of installing each component manually, this project provides a reusable Bash provisioning script that performs the initial server setup automatically.

The script can be used as a starting point for:

* Azure VM provisioning
* Linux server automation
* DevOps automation
* Infrastructure provisioning
* Node.js application server setup
* CI/CD environment preparation
* Cloud engineering practice

---

## Architecture

The provisioning process installs the following stack:

```text
                Azure
                  │
                  ▼
          Ubuntu 24.04 LTS VM
                  │
        ┌─────────┼─────────┐
        │         │         │
        ▼         ▼         ▼
      Nginx     Node.js    MySQL
                  │
                  ▼
                 PM2
                  │
                  ▼
          Node.js Application
```

Typical application traffic can later be configured as:

```text
Internet
   │
   │ HTTP / HTTPS
   ▼
 Nginx
   │
   │ Reverse Proxy
   ▼
 PM2
   │
   ▼
 Node.js Application
   │
   ▼
 MySQL
```

---

## What the Script Installs

### Node.js

Installs **Node.js 24.x** using the official NodeSource repository.

The installation also provides npm.

### Nginx

Installs Nginx and configures the service to:

* Start automatically when the VM boots
* Start immediately after installation

Nginx can later be configured as a reverse proxy for the Node.js application.

### MySQL

Installs MySQL Server and configures the service to:

* Start automatically when the VM boots
* Start immediately after installation

### PM2

Installs PM2 globally through npm.

PM2 can be used to run and manage Node.js applications in production.

---

## Prerequisites

Before running the script, you need:

* An Azure account
* An Ubuntu 24.04 LTS Azure VM
* SSH access to the VM
* A user account with `sudo` privileges
* Internet connectivity from the VM

The script was tested on an **Ubuntu 24.04 LTS Azure VM**.

Example VM environment:

```text
OS: Ubuntu 24.04 LTS
Architecture: x86_64
CPU: 2 vCPU
Memory: 4 GB
Disk: 30 GB
Cloud: Microsoft Azure
```

---

## Usage

### 1. Connect to the Azure VM

From Azure Cloud Shell or your local terminal:

```bash
ssh -i <your-private-key.pem> azureuser@<VM_PUBLIC_IP>
```

Example:

```bash
ssh -i myvm_key.pem azureuser@20.41.233.189
```

Replace the IP address and key name with your own values.

---

### 2. Clone the repository

```bash
git clone https://github.com/<your-github-username>/azure-ubuntu-vm-provisioning.git
```

```bash
cd azure-ubuntu-vm-provisioning
```

---

### 3. Make the script executable

```bash
chmod +x setup.sh
```

---

### 4. Run the provisioning script

```bash
./setup.sh
```

The script will request `sudo` privileges when required.

---

## Installed Software Verification

After the script finishes, verify the installed versions:

### Node.js

```bash
node -v
```

Example:

```text
v24.x.x
```

### npm

```bash
npm -v
```

### PM2

```bash
pm2 -v
```

### Nginx

```bash
nginx -v
```

### MySQL

```bash
mysql --version
```

---

## Verify Services

Check Nginx:

```bash
sudo systemctl status nginx
```

Check MySQL:

```bash
sudo systemctl status mysql
```

Verify that services are configured to start automatically:

```bash
systemctl is-enabled nginx
systemctl is-enabled mysql
```

Expected result:

```text
enabled
```

You can also test the Nginx configuration:

```bash
sudo nginx -t
```

Expected result:

```text
syntax is ok
test is successful
```

---

## Script Features

The script uses:

```bash
set -euo pipefail
```

This helps make the provisioning process safer by:

* Exiting when a command fails
* Detecting unset variables
* Detecting failures in pipelines

The script also performs basic version verification after installing Node.js and PM2.

---

## Current Scope

This project focuses on **initial VM software provisioning**.

It does not currently automate:

* Node.js application deployment
* Git deployment
* Nginx reverse-proxy configuration
* SSL/TLS certificate configuration
* MySQL database/user creation
* Environment variable management
* PM2 application startup configuration
* Azure Network Security Group configuration
* Firewall configuration
* Monitoring and alerting
* Backup configuration

These can be added as future improvements.

---

## Example Production Flow

A typical deployment can use this project as the initial server setup:

```text
1. Create Azure Ubuntu VM
          │
          ▼
2. Connect through SSH
          │
          ▼
3. Run setup.sh
          │
          ▼
4. Node.js + Nginx + MySQL + PM2
          │
          ▼
5. Deploy Node.js application
          │
          ▼
6. Configure PM2
          │
          ▼
7. Configure Nginx reverse proxy
          │
          ▼
8. Configure HTTPS
          │
          ▼
9. Application available through the Internet
```

---

## Security Considerations

This script is intended for initial provisioning and learning purposes.

Before using it in a production environment, consider implementing:

* Azure Network Security Groups
* UFW/firewall rules
* SSH key authentication
* Restricted SSH access
* HTTPS/TLS
* MySQL security hardening
* Non-root application execution
* Secrets management
* Automatic security updates
* Monitoring and logging
* Backup and recovery procedures

Do not store passwords, private keys, API keys, database credentials, or other secrets in this repository.

---

## Future Improvements

Potential improvements include:

* Add PM2 startup configuration
* Add Nginx reverse-proxy automation
* Add SSL/TLS automation
* Add application deployment
* Add MySQL database/user provisioning
* Add UFW configuration
* Add Azure CLI automation
* Add Terraform infrastructure provisioning
* Add Ansible configuration management
* Add CI/CD integration
* Add automated validation tests
* Add logging and monitoring setup

---

## Technologies

* Bash
* Linux
* Ubuntu
* Microsoft Azure
* Node.js
* npm
* Nginx
* MySQL
* PM2
* Git

---

## License

This project is licensed under the MIT License.

See the `LICENSE` file for details.

---

## Author

**Hari Priyan**
DevOps Engineer

This project demonstrates practical experience with Linux server provisioning, Azure virtual machines, Bash automation, and application server setup.
