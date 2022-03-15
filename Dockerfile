FROM centos

RUN sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-* \
    && sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-* \
    && dnf clean all \
    && dnf -y swap centos-linux-repos centos-stream-repos
#This commands are for the ERROR: AppStream Error: Failed to download metadata 
#for repo ‘appstream’: Cannot prepare internal mirrorlist: No URLs in mirrorlist
#in CentOS 8. Solution in https://proyectoa.com/solucion-al-error-failed-to-download-metadata-for-repo-appstream-en-centos-8/

RUN yum -y install firewalld \
    && systemctl start firewalld \
    && systemctl enable firewalld \
    && systemctl status firewalld
#These are for installing the firewall

RUN firewall-cmd --zone=public --add-port=80/tcp --permanent \
    && firewall-cmd --permanent --zone=trusted --add-interface=docker0 \
    && firewall-cmd --reload
#These are for the ERROR: - Curl error (6): Couldn't resolve host name for
# http://mirrorlist.centos.org/?release=8&arch=x86_64&repo=AppStream&infra=container
# [Could not resolve host: mirrorlist.centos.org]
#Solution in https://forums.centos.org/viewtopic.php?f=54&t=74270 


RUN yum -y install httpd

RUN echo "Hola mundo" > /var/www/html/index.html

EXPOSE 80

ENTRYPOINT ["/usr/sbin/httpd", "-DFOREGROUND"]

