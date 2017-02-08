all: pull build tag push

pull:
	sudo docker pull centos:7

build:
	sudo docker build -t centos-lamp .

tag:
	sudo docker tag centos-lamp openmedicus/centos-lamp:latest

push:
	sudo docker push openmedicus/centos-lamp

run:
	sudo docker run -i -t centos-lamp /bin/bash
