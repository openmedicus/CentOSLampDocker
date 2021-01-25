CENTOS=7
PHP_VERSION=7.1

all: pull build tag push

pull:
	podman pull centos:${CENTOS}

build:
	podman build --format=docker --no-cache -t centos-lamp .

tag:
	podman tag centos-lamp openmedicus/centos-lamp:${PHP_VERSION}

push:
	podman push openmedicus/centos-lamp:${PHP_VERSION}

run:
	podman run -i -t centos-lamp /bin/bash
