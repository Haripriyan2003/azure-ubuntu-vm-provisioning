#!/bin/bash

# ============================================================
# Azure Ubuntu VM Provisioning Script
# Author: Hari Priyan
# Role: DevOps Engineer
#
# Installs and verifies:
#   - Node.js 24.x
#   - npm
#   - Nginx
#   - MySQL Server
#   - PM2
#
# Tested on:
#   Ubuntu 24.04 LTS
#   Microsoft Azure VM
# ============================================================

set -euo pipefail

echo ""
echo "============================================================"
echo "        Azure Ubuntu VM Provisioning"
echo "============================================================"
echo ""

# ------------------------------------------------------------
# 1. Update package lists
# ------------------------------------------------------------

echo "[1/7] Updating package lists..."

sudo apt-get update -y

echo "✓ Package lists updated."
echo ""

# ------------------------------------------------------------
# 2. Install required dependencies
# ------------------------------------------------------------

echo "[2/7] Installing required dependencies..."

sudo apt-get install -y curl ca-certificates

echo "✓ Dependencies installed."
echo ""

# ------------------------------------------------------------
# 3. Install Node.js 24.x
# ------------------------------------------------------------

echo "[3/7] Installing Node.js 24.x..."

curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -

sudo apt-get update -y

sudo apt-get install -y nodejs

echo ""
echo "Node.js version:"
node --version

echo "npm version:"
npm --version

echo ""
echo "✓ Node.js and npm installed."
echo ""

# ------------------------------------------------------------
# 4. Install and configure Nginx
# ------------------------------------------------------------

echo "[4/7] Installing Nginx..."

sudo apt-get install -y nginx

sudo systemctl enable nginx
sudo systemctl start nginx

echo ""
echo "Nginx version:"
nginx -v 2>&1

echo ""
echo "Checking Nginx configuration..."

sudo nginx -t

echo ""
echo "Checking Nginx service..."

if sudo systemctl is-active --quiet nginx; then
    echo "✓ Nginx is running."
else
    echo "✗ Nginx is not running."
    exit 1
fi

echo ""

# ------------------------------------------------------------
# 5. Install and configure MySQL
# ------------------------------------------------------------

echo "[5/7] Installing MySQL Server..."

sudo apt-get install -y mysql-server

sudo systemctl enable mysql
sudo systemctl start mysql

echo ""
echo "MySQL version:"
mysql --version

echo ""
echo "Checking MySQL service..."

if sudo systemctl is-active --quiet mysql; then
    echo "✓ MySQL is running."
else
    echo "✗ MySQL is not running."
    exit 1
fi

echo ""

# ------------------------------------------------------------
# 6. Install PM2
# ------------------------------------------------------------

echo "[6/7] Installing PM2..."

sudo npm install -g pm2

echo ""
echo "PM2 version:"
pm2 --version

echo ""
echo "✓ PM2 installed."
echo ""

# ------------------------------------------------------------
# 7. Final verification
# ------------------------------------------------------------

echo "[7/7] Performing final verification..."

echo ""
echo "------------------------------------------------------------"
echo "Software Versions"
echo "------------------------------------------------------------"

echo "Node.js : $(node --version)"
echo "npm     : $(npm --version)"
echo "PM2     : $(pm2 --version)"
echo "Nginx   : $(nginx -v 2>&1)"
echo "MySQL   : $(mysql --version)"

echo ""
echo "------------------------------------------------------------"
echo "Service Status"
echo "------------------------------------------------------------"

echo ""
echo "Nginx:"
sudo systemctl is-active nginx

echo ""
echo "MySQL:"
sudo systemctl is-active mysql

echo ""
echo "------------------------------------------------------------"
echo "Boot Configuration"
echo "------------------------------------------------------------"

echo ""
echo "Nginx:"
sudo systemctl is-enabled nginx

echo ""
echo "MySQL:"
sudo systemctl is-enabled mysql

echo ""
echo "============================================================"
echo "       Provisioning Completed Successfully!"
echo "============================================================"
echo ""
echo "Installed software:"
echo "  ✓ Node.js 24.x"
echo "  ✓ npm"
echo "  ✓ Nginx"
echo "  ✓ MySQL Server"
echo "  ✓ PM2"
echo ""
echo "Services:"
echo "  ✓ Nginx running"
echo "  ✓ MySQL running"
echo ""
echo "The VM is ready for Node.js application deployment."
echo ""
