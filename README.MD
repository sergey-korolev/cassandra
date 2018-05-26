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
vagrant up node-1 --no-provision
```
##down
```bash
vagrant destroy node-1
```

#Ops
##Update inventory
```bash
vagrant provision node-1 --provision-with ansible
```
##Install standalone cassandra
```bash
ansible-playbook standalone.yml -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --limit node-1
```
##Install repair cron job
```bash
ansible-playbook repair_job.yml -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --limit node-1
```
##Run repair job, options can be overrided by repair_manual_options
```bash
ansible-playbook repair.yml -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --limit node-1
```

#Load and benchmark
## YCSB
```bash
vagrant up ycsb --provision-with ansible
ansible-playbook ycsb.yml -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
```
## Init schema
```
cqlsh> create keyspace ycsb
    WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor': 1 };
cqlsh> USE ycsb;
cqlsh> create table usertable (
    y_id varchar primary key,
    field0 varchar,
    field1 varchar,
    field2 varchar,
    field3 varchar,
    field4 varchar,
    field5 varchar,
    field6 varchar,
    field7 varchar,
    field8 varchar,
    field9 varchar);
```
## Load data
```bash
vagrant ssh ycsb
cd ycsb-0.12.0/
./bin/ycsb load cassandra2-cql -p hosts=206.81.8.65 -P workloads/workloada
vi workloads/workloada
#recordcount=10000000
#operationcount=10000000
```
## Run queries
```bash
./bin/ycsb run cassandra2-cql -p hosts=206.81.8.65 -P workloads/workloada -s -threads 10 -target 100
```