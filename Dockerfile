FROM alpine:3
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]

ARG USERS_CONF_FILE=/users.conf
ARG AUTHORIZED_KEYS_DIR=/authorized_keys

ENV USERS_CONF_FILE=$USERS_CONF_FILE
ENV AUTHORIZED_KEYS_DIR=$AUTHORIZED_KEYS_DIR

RUN apk add -U --no-cache openssh-server \
  && mkdir /var/lib/sftp

COPY entrypoint.sh /
COPY sshd_config /etc/ssh/
