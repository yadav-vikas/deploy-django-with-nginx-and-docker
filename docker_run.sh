#!/bin/sh

echo killing old docker processes....................
docker-compose rm -fs

echo building docker containers....................
docker-compose up --build -d

echo making migrations on docker containers....................
docker-compose exec web python manage.py makemigrations
docker-compose exec web python manage.py migrate

echo starting django server....................
docker-compose exec web python manage.py runserver