#!/usr/bin/env bash

virtualenv .venv
. .venv/bin/activate && pip install -r requirements.txt

vagrant plugin install vagrant-digitalocean