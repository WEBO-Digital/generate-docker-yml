@echo off

SET project_name=%1
SET port_number=%2
SET php_version=%3

if "%project_name%"=="" (
    echo Please provide a project name.
    exit /b
)

if "%port_number%"=="" (
    SET /P port_number=Enter port number:
)

if "%php_version%"=="" (
    SET php_version="8.2"
)else (
    SET php_version=%3 
)

(
echo version: '3.1'
echo services:
echo   %project_name%web:
echo     container_name: %project_name%web
echo     image: intuji/apache-php:%php_version%
echo     expose:
echo       - 80
echo     ports:
echo       - %port_number%:80
echo     depends_on:
echo       - %project_name%db
echo     volumes:
echo       - ./%project_name%_html:/var/www/html
echo     environment:
echo       MYSQL_HOST: %project_name%db
echo       MYSQL_USER: %project_name%
echo       MYSQL_PASSWORD: %project_name%
echo/
echo   %project_name%db:
echo     container_name: %project_name%db
echo     restart: always
echo     image: mysql:8
echo     volumes:
echo       - ./%project_name%_db:/var/lib/mysql
echo     expose:
echo       - 3306
echo     environment:
echo       MYSQL_ROOT_PASSWORD: toor
echo       MYSQL_USER: %project_name%
echo       MYSQL_PASSWORD: %project_name%
echo       MYSQL_DATABASE: %project_name%
) > docker-compose.yml

echo Docker Compose file created for %project_name% with port %port_num           