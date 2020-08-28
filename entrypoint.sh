#!/bin/sh
set -e

for LINE in `cat ${USERS_CONF_FILE}`;do
  USER_NAME=`echo $LINE|cut -f1 -d':'`
  USER_ID=`echo $LINE|cut -f2 -d':'`
  USER_PASS=`xxd -l16 -p /dev/urandom`
  USER_HOME=/home/${USER_NAME}

  adduser -D -u $USER_ID $USER_NAME
  echo -e "${USER_PASS}\n${USER_PASS}"|passwd $USER_NAME

  mkdir ${USER_HOME}/.ssh
  cat ${AUTHORIZED_KEYS_DIR}/${USER_NAME} > ${USER_HOME}/.ssh/authorized_keys
  chown -R ${USER_NAME}:${USER_NAME} ${USER_HOME}/.ssh
  chmod 0700 ${USER_HOME}/.ssh
  chmod 0600 ${USER_HOME}/.ssh/authorized_keys

  echo "
  
  Match User ${USER_NAME}
  ChrootDirectory /var/lib/sftp/${USER_NAME}
  ForceCommand internal-sftp
  AllowTcpForwarding no" >> /etc/ssh/sshd_config

  chown ${USER_NAME}:${USER_NAME} /var/lib/sftp/${USER_NAME}/*
done

exec $@