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

ADMIN_PASSWORD="${ADMIN_PASSWORD:-admin12345}"

service redis-server start


if [ ! -f /var/lib/openvas/private/CA/cakey.pem ]; then {
  openvas-setup
}
fi
chown -R root:root /var/lib/openvas
echo -e "\nCreando certificados..."
openvas-manage-certs -a -f
echo -e "\nActualizando..."
greenbone-nvt-sync
greenbone-scapdata-sync
greenbone-certdata-sync

echo -e "\nIniciando servicios..."
/etc/init.d/openvas-scanner start
/etc/init.d/openvas-manager start
openvasmd --update --verbose --progress
openvasmd --rebuild --verbose --progress

if openvas-check-setup --v9 --server | grep -q "No users found"; then {
  echo -e "\nNingún usuario creado, creando usuario admin:"
  openvasmd --create-user=admin --role=Admin && openvasmd --user=admin --new-password=$ADMIN_PASSWORD
} else {
  echo -e "\nCambiando password del usuario admin:"
  openvasmd --user=admin --new-password=$ADMIN_PASSWORD
}
fi

openvas-check-setup --v9
/etc/init.d/openvas-gsa start
