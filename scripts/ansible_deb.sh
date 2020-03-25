#!/bin/sh -eux
 apt update
 apt install software-properties-common
 apt-add-repository --yes --update ppa:ansible/ansible
 apt install ansible
