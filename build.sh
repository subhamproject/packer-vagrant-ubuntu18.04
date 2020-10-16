#!/bin/bash

FILE="ubuntu-18.04-vagrant.json"

[ -n "$(which packer)" ] && packer build $FILE