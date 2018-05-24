#Requirements:
* virtualbox (just installed for vagrant)
* vagrant

#Init local dev environment
```bash
./env_init.sh
```

#Up/Down node for cassandra in DO
##env
```bash
DIGITALOCEAN_ACCESS_TOKEN=
DIGITALOCEAN_SSH_KEY_IDS=
DIGITALOCEAN_SSH_KEY_PATH=
DIGITALOCEAN_SSH_KEY_NAME=
```
##up
```bash
vagrant up --no-provision
```
##down
```bash
vagrant destroy
```
