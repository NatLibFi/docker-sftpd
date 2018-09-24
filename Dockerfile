FROM alpine:3.8
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]

RUN apk add -U --no-cache openssh-server \
  && ssh-keygen -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key \
  #&& sed -i '/^ftp/d' /etc/passwd \
  #&& echo 'ftp:x:21:21::/var/lib/ftp:/bin/sh' >> /etc/passwd \
  && mkdir -p /var/lib/ftp/.ssh \
  && chown -R root:root /var/lib/ftp && chmod 0755 /var/lib/ftp \
  && chown ftp:ftp /var/lib/ftp/.ssh && chmod 0700 /var/lib/ftp/.ssh \
  && PASS=$(cat /dev/urandom|base64|head -c16) \
    echo -e "$PASS\n$PASS" | passwd ftp \
  && rm -rf /tmp/* /var/cache/apk/*

COPY entrypoint.sh /
COPY sshd_config /etc/ssh/
