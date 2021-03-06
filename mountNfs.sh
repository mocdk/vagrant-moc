#!/bin/bash

VAGRANT_IP="192.168.66.129";
MAJOR_MAC_VERSION=$(sw_vers -productVersion | awk -F '.' '{print $1 "." $2}')

if [ ! -d "workdir" ]; then
	mkdir workdir
fi

if [ "$MAJOR_MAC_VERSION" == "10.10" ]
then
	sudo mount -orw -oresvport,noowners -t nfs $VAGRANT_IP:/home/sites workdir
else
	sudo mount -o vers=4,resvport,rw,noowners -t nfs $VAGRANT_IP:/home/sites workdir
fi
