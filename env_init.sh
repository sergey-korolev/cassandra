#!/usr/bin/env bash

virtualenv .venv
. .venv/bin/activate && pip install -r requirements.txt

vagrant plugin install vagrant-digitalocean

mkdir -p repair_logs

ansible-galaxy install mrlesmithjr.oracle-java8 -p ./roles/