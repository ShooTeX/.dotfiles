#!/bin/bash

if ["$EUID" -ne 0]
  then echo "Please run as root"
  exit
fi

apt-get update
apt-get install zsh -y

curl -L git.io/antigen > ~/antigen.zsh

zsh
