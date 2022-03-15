FROM centos

RUN sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-* \
    && sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-* \
    && dnf clean all \
    && dnf -y swap centos-linux-repos centos-stream-repos
#This commands are for the ERROR: AppStream Error: Failed to download metadata 
#for repo ‘appstream’: Cannot prepare internal mirrorlist: No URLs in mirrorlist
#in CentOS 8. Solution in https://proyectoa.com/solucion-al-error-failed-to-download-metadata-for-repo-appstream-en-centos-8/

RUN yum -y install httpd

RUN echo "Hola mundo" > /var/www/html/index.html

EXPOSE 80

ENTRYPOINT ["/usr/sbin/httpd", "-DFOREGROUND"]

