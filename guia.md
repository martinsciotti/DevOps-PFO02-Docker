# Guía PFO 02 DevOps

## Parte 1: Aplicación Web con Docker

### Instalación y Configuración Inicial

#### Primeros comandos básicos
# Listar imágenes descargadas
docker images
# Listar contenedores en ejecución
docker ps
### Trabajando con Servidores Web

#### Búsqueda de imágenes
# Buscar imágenes de Nginx disponibles
docker search nginx
#### Descarga de imagen Nginx
# Descargar la imagen oficial de Nginx
docker pull nginx
#### Creación de contenedor Nginx
# Crear y ejecutar un contenedor Nginx
docker run --name mi-web -p 8080:80 -d nginx

Explicación:
- `--name mi-web`: Asigna el nombre "mi-web" al contenedor
- `-p 8080:80`: Mapea el puerto 8080 del host al puerto 80 del contenedor
- `-d`: Ejecuta el contenedor en segundo plano (modo detached)
- `nginx`: Usa la imagen nginx descargada previamente

### Trabajando con MySQL

#### Descarga de imagen MySQL
# Descargar la imagen oficial de MySQL
docker pull mysql
#### Creación de contenedor MySQL
# Crear y ejecutar un contenedor MySQL
docker run --name mi-mysql -e MYSQL_ROOT_PASSWORD=1234 -p 3306:3306 -d mysql

Explicación:
- `--name mi-mysql`: Asigna el nombre "mi-mysql" al contenedor
- `-e MYSQL_ROOT_PASSWORD=1234`: Establece la contraseña para el usuario root
- `-p 3306:3306`: Mapea el puerto 3306 del host al puerto 3306 del contenedor
- `-d mysql`: Usa la imagen mysql en segundo plano

### Conectando Contenedores

#### Creación de red Docker
# Crear una red para que los contenedores se comuniquen
docker network create mi-red
#### Conectar contenedores a la red
# Conectar el contenedor Nginx a la red
docker network connect mi-red mi-web
# Conectar el contenedor MySQL a la red
docker network connect mi-red mi-mysql

### Desarrollo Web con Docker

#### Construcción de la imagen personalizada
# Construir la imagen desde el Dockerfile
docker build -t mi-aplicacion-web .
#### Ejecución del contenedor de aplicación
# Ejecutar contenedor con la aplicación
docker run --name mi-aplicacion -p 8080:80 --network mi-red -d mi-aplicacion-web
#### Conexión a MySQL y creación de base de datos
# Acceder al cliente MySQL dentro del contenedor
docker exec -it mi-mysql mysql -u root -p

### Publicación de Imágenes

#### Etiquetado de imagen
# Etiquetar la imagen para Docker Hub
docker tag mi-aplicacion-web user/mi-aplicacion-web:v1

## Parte 2: Dockerización de Proyecto Existente

### Preparación del Proyecto
### Creación del Dockerfile

Crear archivo Dockerfile en la raíz del proyecto con el siguiente contenido:
FROM php:8.0-apache
# Instalar extensiones de PHP necesarias
RUN docker-php-ext-install mysqli pdo pdo_mysql
# Habilitar mod_rewrite para URLs amigables
RUN a2enmod rewrite
# Copiar todos los archivos del proyecto al directorio de Apache
COPY . /var/www/html/
# Establecer permisos adecuados
RUN chown -R www-data:www-data /var/www/html
# Exponer el puerto 80
EXPOSE 80
# Comando por defecto para iniciar Apache
CMD ["apache2-foreground"]
### Pruebas y Ejecución
# Construir la imagen desde el Dockerfile
docker build -t mi-proyecto-web .
#### Ejecución del contenedor
# Ejecutar el contenedor
docker run -p 8080:80 -d --name mi-app mi-proyecto-web

# Acceder al contenedor para depuración
docker exec -it mi-app bash
### Publicación en Docker Hub
#### Etiquetado de imagen
# Etiquetar la imagen para Docker Hub
docker tag mi-proyecto-web user/

#### Subida de imagen a Docker Hub
# Subir la imagen etiquetada a Docker Hub
docker push user/


## Problemas Comunes y Soluciones

### Problema: Puertos ya en uso
**Error:** "port is already allocated"

**Solución:** 
# Verificar qué puertos están en uso
netstat -tulpn | grep 8080

# Usar un puerto diferente
docker run -p 8081:80 -d --name mi-app mi-proyecto-web

### Problema: Permisos insuficientes
**Error:** "Permission denied" al acceder a archivos

**Solución:** Añadir al Dockerfile:
```dockerfile
RUN chown -R www-data:www-data /var/www/html

### Problema: Extensiones PHP faltantes
**Error:** "Call to undefined function mysqli_connect()"

**Solución:** Añadir al Dockerfile:
RUN docker-php-ext-install mysqli pdo pdo_mysql

## Comandos de Referencia Rápida

### Gestión de Contenedores
# Listar contenedores en ejecución
docker ps

# Ejecutar un contenedor
docker run --name [nombre] -p [puerto-host]:[puerto-contenedor] -d [imagen]

# Detener un contenedor
docker stop [nombre-o-id]

# Iniciar un contenedor detenido
docker start [nombre-o-id]

# Eliminar un contenedor
docker rm [nombre-o-id]

# Ver logs de un contenedor
docker logs [nombre-o-id]

# Ejecutar comando dentro de un contenedor
docker exec -it [nombre-o-id] [comando]


### Gestión de Imágenes
# Listar imágenes
docker images

# Descargar una imagen
docker pull [nombre-imagen]

# Construir una imagen desde Dockerfile
docker build -t [nombre-imagen] [directorio]

# Eliminar una imagen
docker rmi [nombre-o-id]

# Etiquetar una imagen
docker tag [imagen-origen] [imagen-destino]

### Gestión de Redes
# Listar redes
docker network ls
# Crear una red
docker network create [nombre-red]

# Conectar un contenedor a una red
docker network connect [nombre-red] [nombre-contenedor]

# Inspeccionar una red
docker network inspect [nombre-red]

### Docker Hub
# Iniciar sesión
docker login

# Subir imagen
docker push [nombre-usuario]/[nombre-imagen]:[tag]

# Descargar imagen
docker pull [nombre-usuario]/[nombre-imagen]:[tag]
