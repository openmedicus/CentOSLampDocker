FROM centos:7
MAINTAINER Mikkel Kruse Johnsen <mikkel@xmedicus.com>

# install http
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
#RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm

# Update
RUN yum -y update

# install httpd
RUN yum -y install httpd vim-enhanced bash-completion unzip

# install mysql
RUN yum install -y mysql postgresql
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# install php
RUN yum install -y php56w php56w-pgsql php56w-mysql php56w-devel php56w-gd php56w-pecl-memcache php56w-pspell php56w-snmp php56w-xmlrpc php56w-xml php56w-ldap php56w-imap php56w-mbstring php56w-soap

# install pip
RUN yum install -y python-pip && pip install "pip>=1.4,<1.5" --upgrade

# Clean yum
RUN yum clean all

# PHP Info
ADD phpinfo.php /var/www/html/

EXPOSE 80

# By default, simply start apache.
RUN sed -i -e 's/#OPTIONS=/OPTIONS="-D FOREGROUND"/g' /etc/sysconfig/httpd
CMD /usr/sbin/apachectl

