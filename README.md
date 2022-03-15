# Docker hola mundo  

Docker es una herramienta de automatización de despliegue de aplicaciones dentro de contenedores.
 
# Construir imagen de Docker

Para contruir la imagen, ejecute el siguiente comando:
```sh
$ docker build -t #minombre .
```

# Consideraciones
### Puerto ocupado

Si el puerto 80 de su equipo se encuentra ocupado, ejecute los siguientes comandos para eliminar el proceso que se encuetra usandolo.

Encontrar proceso:
```sh
$ sudo netstat -pna | grep 80
```

Matar el proceso:
```sh
$ sudo kill #idprocess
```

### CentOS 8 yum ERROR

En el Dockerfile se encuentra el comando

```
RUN sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-* \
    && sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-* \
    && dnf clean all \
    && dnf -y swap centos-linux-repos centos-stream-repos
```
Esto es debido a que CentOS 8 ha cambiado los repositorios de paquetes de URL. Por lo tanto hay que modificar las URL de descarga de los paquetes. Dicha solución se encontró [aquí](https://proyectoa.com/solucion-al-error-failed-to-download-metadata-for-repo-appstream-en-centos-8/).
# Crear container

Para crear el contenedor se debe ejecutar la siguiente instrucción:
```sh
$ docker run --rm  --name web -t1 -p 80:80 apache
```

> Nota: Para salir, pulse Ctrl + c

Observe la [documentación] de Docker.


[documentación]: <https://docs.docker.com/get-started/>

