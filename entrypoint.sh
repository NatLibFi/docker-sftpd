#!/bin/sh
set -e

for KEY in $(env|grep AUTHORIZED_KEY|cut -f2 -d'=');do
  echo "ssh-rsa $KEY  " >> /var/lib/ftp/.ssh/authorized_keys
done

chown -R ftp:ftp /var/lib/ftp/.ssh/authorized_keys
chmod 0600 /var/lib/ftp/.ssh/authorized_keys

exec $@
