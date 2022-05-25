#!/bin/sh

echo killing old docker processes....................
docker-compose rm -fs

echo building docker containers....................
docker-compose -f docker-compose.prod.yml up -d --build

echo making migrations on docker containers....................
docker-compose -f docker-compose.prod.yml exec web python manage.py migrate --noinput

echo running collectstatic..
docker-compose -f docker-compose.prod.yml exec web python manage.py collectstatic --no-input --clear

echo starting django server....................
docker-compose -f docker-compose.prod.yml exec web python manage.py runserver

echo checking logs................
docker-compose -f docker-compose.prod.yml logs -f