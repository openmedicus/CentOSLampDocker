all: build tag push

build:
	sudo docker build -t centos-lamp .

tag:
	sudo docker tag -f centos-lamp openmedicus/centos-lamp:latest

push:
	sudo docker push openmedicus/centos-lamp

