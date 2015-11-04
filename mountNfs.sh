#!/bin/bash

if [ ! -d "workdir" ]; then
	mkdir workdir
fi
sudo mount -o vers=4,resvport,rw -t nfs 192.168.66.120:/home/sites workdir
