#!/bin/bash

# Получаем текущую дату в формате YYYY-MM-DD
DATE=$(date +\%F)

# Определяем имя контейнера, пользователя и базы данных
CONTAINER_NAME="postgres_db_bee_verse"
DB_USER="postgres"
DB_NAME="bee_verse"

# Создаем бэкап с датой в имени файла
docker exec -t $CONTAINER_NAME pg_dump -U $DB_USER $DB_NAME > ./backup_$DATE.sql
