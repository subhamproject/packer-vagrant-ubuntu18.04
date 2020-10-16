#!/bin/bash

FILE="ubuntu-18.04-vagrant.json"

[ -n "$(which packer)" ] && packer build $FILE

# vagrant box add --name "packer/ubuntu18-04" output/ubuntu-18.04.1.box
