#!/bin/bash

if [ -z "$1" ]; then
    echo "Please provide a project name."
    exit 1
fi

if [ -z "$2" ]; then
    read -p "Enter port number: " port_number
else
    port_number=$2
fi

if [ ! -z "$3" ]; then
    php_version=$3
else
    php_version="8.2"
fi

cat <<EOT > docker-compose.yml
version: '3.1'
services:
  $1web:
    container_name: $1web
    image: intuji/apache-php:$php_version
    expose:
      - 80
    ports:
      - $port_number:80
    depends_on:
      - $1db
    volumes:
      - ./$1_html:/var/www/html
    environment:
      MYSQL_HOST: $1db
      MYSQL_USER: $1
      MYSQL_PASSWORD: $1

  $1db:
    container_name: $1db
    restart: always
    image: mysql:8
    volumes:
      - ./$1_db:/var/lib/mysql
    expose:
      - 3306
    environment:
      MYSQL_ROOT_PASSWORD: toor
      MYSQL_USER: $1
      MYSQL_PASSWORD: $1
      MYSQL_DATABASE: $1
EOT

echo "Docker Compose file created for $1 with port $port_number."

