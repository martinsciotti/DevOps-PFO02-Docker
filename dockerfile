FROM php:8.0-apache

# Instalar extensiones de PHP que podrías necesitar
# (puedes eliminar las que no uses)
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Habilitar mod_rewrite para URLs amigables (útil si tu aplicación lo necesita)
RUN a2enmod rewrite

# Copiar todos los archivos del proyecto al directorio de Apache
# Esto incluirá tanto index.html como backend.php
COPY . /var/www/html/

# Establecer permisos adecuados
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80 (Apache usa este puerto por defecto)
EXPOSE 80

# Comando por defecto para iniciar Apache
CMD ["apache2-foreground"]