FROM centos

RUN sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-*

RUN sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-*

RUN dnf clean all

RUN dnf -y swap centos-linux-repos centos-stream-repos

RUN yum -y install firewalld

RUN systemctl start firewalld

RUN systemctl enable firewalld

RUN systemctl status firewalld

RUN firewall-cmd --zone=public --add-port=80/tcp --permanent

RUN firewall-cmd --permanent --zone=trusted --add-interface=docker0

RUN firewall-cmd --reload

RUN yum -y install httpd

RUN echo "Hola mundo" > /var/www/html/index.html

EXPOSE 80

ENTRYPOINT ["/usr/sbin/httpd", "-DFOREGROUND"]

