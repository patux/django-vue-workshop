#!/usr/bin/env bash
cd /vagrant/workshop
virtualenv vjournal # Crear el entorno virtual
source vjournal/bin/activate # Habilitar el entorno virtual
pip3 install Django djangorestframework django-cors-headers
django-admin startproject journal_backend
cd journal_backend
django-admin startapp app_ejemplo

python manage.py makemigrations
python manage.py migrate

