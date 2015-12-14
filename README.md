Branch for earlier versions than El Capitan
==============

Because of an error with NFS mount crashing i reverted the support for El Capitan.


MOC Vagrant development machine
===============================

This repository contains the Vagrant setup for a standrad MOC development machine

The machine uses Ansible for provisioning, and will install Apache 2.4 with php 5.5 using php_fpm. It will also install
redis, memcache, mongodb, ElasticSearch, MySQL and relevant PHP bindings.

Varnish is installed, and listening on port 80. Apache will listen on port 80.
 

Install
-------

Make sure that you have Ansible installed on you hosts (ie. your laptop). On MAC OSX install X-Code and then do


	sudo easy_install pip
	sudo pip install ansible --quiet
	
