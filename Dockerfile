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
RUN yum install -y php71w php71w-pgsql php71w-mysql php71w-mysqli php71w-devel php71w-gd php71w-pecl-memcache php71w-pspell php71w-snmp php71w-xmlrpc php71w-xml php71w-ldap php71w-imap php71w-mbstring php71w-soap

# install pip
RUN yum install -y python-pip && pip install "pip>=1.4,<1.5" --upgrade

# Addiational
RUN yum install -y ImageMagick

# Clean yum
RUN yum clean all

# PHP Info
ADD phpinfo.php /var/www/html/

# AllowOverride
RUN sed -i -e 's!AllowOverride none!AllowOverride all!g' /etc/httpd/conf/httpd.conf
RUN sed -i -e 's!AllowOverride None!AllowOverride All!g' /etc/httpd/conf/httpd.conf

EXPOSE 80

# By default, simply start apache.
RUN sed -i -e 's/#OPTIONS=/OPTIONS="-D FOREGROUND"/g' /etc/sysconfig/httpd
CMD /usr/sbin/apachectl

