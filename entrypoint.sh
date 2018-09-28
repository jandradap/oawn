#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#
# ------------------------------------------------------------------
# [Jorge Andrada Prieto] [monino@gmail.com]
# Title: entrypoint.sh
# Description: entrypoint for oawn image
# ------------------------------------------------------------------
#

#debug
# set -x
# trap read debug

service redis-server start

if [ ! -f /var/lib/openvas/private/CA/cakey.pem ]; then {
  openvas-setup
}
fi

greenbone-nvt-sync
greenbone-certdata-sync
greenbone-scapdata-sync
openvasmd --update --verbose --progress
# openvas-manager restart
# openvas-scanner restart

openvas-check-setup --v9
openvas-start


# DATAVOL=/var/lib/openvas/mgr/
# OV_PASSWORD=${OV_PASSWORD:-admin}
# WEB_CERT_FILE=${WEB_CERT_FILE:-""}
# WEB_KEY_FILE=${WEB_KEY_FILE:-""}
#
# if [ ! -z "$WEB_CERT_FILE" -a ! -z "$WEB_KEY_FILE" ]; then
#         echo 'DAEMON_ARGS="--mlisten 127.0.0.1 -m 9390 -k '$WEB_KEY_FILE' -c '$WEB_CERT_FILE'"' >> /etc/default/openvas-gsa
# fi
#
# redis-server /etc/redis/redis.conf
#
# echo "Testing redis status..."
# X="$(redis-cli ping)"
# while  [ "${X}" != "PONG" ]; do
#         echo "Redis not yet ready..."
#         sleep 1
#         X="$(redis-cli ping)"
# done
# echo "Redis ready."
#
# echo "Checking for empty volume"
# [ -e "$DATAVOL/tasks.db" ] || SETUPUSER=true
#
# echo "Restarting services"
# service openvas-scanner restart
# service openvas-manager restart
# service openvas-gsa restart
#
# echo "Reloading NVTs"
# openvasmd --rebuild
#
# if [ -n "$SETUPUSER" ]; then
#   echo "Setting up user"
#   openvasmd openvasmd --create-user=admin
#   openvasmd --user=admin --new-password=$OV_PASSWORD
# fi
#
# echo "Checking setup"
# /openvas/openvas-check-setup --v9
#
# if [ -z "$BUILD" ]; then
#   echo "Tailing logs"
#   tail -F /var/log/openvas/*
# fi
