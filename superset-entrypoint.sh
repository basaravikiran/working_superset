#!/bin/bash
superset db upgrade
export FLASK_APP=superset
superset init
superset fab create-admin \
               --username admin \
               --firstname Superset \
               --lastname Admin \
               --email admin@superset.com \
               --password admin
#superset run --host=0.0.0.0 -p 8088
gunicorn -w 3 -k gevent --timeout 120 -b 0.0.0.0:${SUPERSET_PORT} "superset.app:create_app()"
