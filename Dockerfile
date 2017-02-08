FROM centos:7
MAINTAINER Mikkel Kruse Johnsen <mikkel@xmedicus.com>

# install http
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm

# Update
RUN yum -y update

# install httpd
RUN yum -y install httpd vim-enhanced bash-completion unzip

# install mysql
RUN yum install -y mysql postgresql
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# install php
RUN yum install -y php php-pgsql php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml php-ldap php-imap php-mbstring php-soap

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

