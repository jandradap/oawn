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
echo "Testing redis status..."
X="$(redis-cli ping)"
while  [ "${X}" != "PONG" ]; do
        echo "Redis not yet ready..."
        sleep 1
        X="$(redis-cli ping)"
done

if [ ! -f /var/lib/openvas/private/CA/cakey.pem ]; then {
  openvas-setup
}
fi

# /etc/init.d/openvas-manager restart
# /etc/init.d/openvas-scanner restart
greenbone-nvt-sync --verbose
greenbone-certdata-sync --verbose
greenbone-scapdata-sync --verbose
/etc/init.d/openvas-manager start
if [ ! -f /var/lib/openvas/plugins/gb_apache_tika_server_detect.nasl.asc ]; then {
  openvasmd --update --verbose --progress && openvasmd --rebuild --verbose --progress
} else {
  openvasmd --update --verbose --progress &&  openvasmd --rebuild --verbose --progress &
}
fi


if openvas-check-setup --v9 --server | grep -q "No users found"; then {
  echo -e "\nNingún usuario creado, creando usuario admin:"
  openvasmd --create-user=admin --role=Admin && openvasmd --user=admin --new-password=$ADMIN_PASSWORD
}
fi

/etc/init.d/greenbone-security-assistant start
openvas-check-setup --v9
openvas-start
