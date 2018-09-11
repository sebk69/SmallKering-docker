#!/bin/bash

echo "Enter admin account username : "
read admin_username
echo "Enter admin account email :"
read admin_email
echo "Enter admin password :"
read admin_password

# clone symfony source
git clone https://github.com/sebk69/SmallKeyring.git server

# create home dir
mkdir home

# create .env file
cp -p server/.env.dist server/.env

# build docker
cd commands
./rebuild-docker

# install dependencies
./composer install


# create database
./console sebk:small-orm:layers-execute

# create admin user
./console sebk:small-user:create-user $admin_email $admin_username $admin_password
./console sebk:small-user:add-role $admin_username SUPER_ADMIN
