# Docker image for OpenSSH SFTPD server

## Usage

- Users configuration file which contains user name and id separated by colon. One user per line. Example `foo:1000`. Path defaults to /users.conf and can be overriden with env variable USERS_CONF_FILE
- User-specific authorized_keys files must be mounted with the name pattern <USER NAME>.authorized_keys, e.g. `foo.authorized_keys`. Path defaults to /authorized_keys and can be overriden with env variable AUTHORIZED_KEYS_DIR
- Host private and public keys must be mounted to /etc/ssh/ssh_host_rsa_key and /etc/ssh/ssh_host_rsa_key.pub
- User-specific SFTP-directories have no write permissions but directories can be mounted there, e.g. `/var/lib/sftp/foo/data`


### Example Docker Swarm stack manifest
```yaml
```

## License and copyright

Copyright (c) 2020 **University Of Helsinki (The National Library Of Finland)**

This project's source code is licensed under the terms of **GNU Affero General Public License Version 3** or any later version.
