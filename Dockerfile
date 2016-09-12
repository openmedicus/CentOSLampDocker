FROM centos:7
MAINTAINER Mikkel Kruse Johnsen <mikkel@xmedicus.com>

# install http
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm

# Update
RUN yum -y update

# install httpd
RUN yum -y install httpd vim-enhanced bash-completion unzip

# install mysql
RUN yum install -y mysql postgresql
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# install php
RUN yum install -y php php-pgsql php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml php-ldap php-imap php-mbstring

# install pip
RUN yum install -y python-pip && pip install "pip>=1.4,<1.5" --upgrade

# install sshd
#RUN yum install -y openssh-server openssh-clients passwd
#RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
#RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && echo 'root:changeme' | chpasswd

# Clean yum
RUN yum clean all

# PHP Info
ADD phpinfo.php /var/www/html/

EXPOSE 80

# By default, simply start apache.
CMD /usr/sbin/apachectl -D FOREGROUND

