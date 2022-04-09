# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sachouam <sachouam@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/01/13 21:39:51 by sachouam          #+#    #+#              #
#    Updated: 2020/02/06 03:00:26 by sachouam         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# mise en place de l'IS0 de base
FROM debian:buster
MAINTAINER sachouam <sachouam@student.42.fr>

# update && upgrade && PACKAGES
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y nginx openssl mariadb-server wget vim
RUN apt-get install -y php7.3 php-mysql php-fpm php-cli php-mbstring

# create_base
ADD ./srcs/database_conf.sql ./database_conf.sql
RUN service mysql start && mysql -u root --skip-password < database_conf.sql

# wordpress
RUN wget https://fr.wordpress.org/latest-fr_FR.tar.gz
RUN tar -zxvf latest-fr_FR.tar.gz
RUN mv wordpress/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html/wordpress/
RUN chmod -R 755 /var/www/html/wordpress/
RUN rm latest-fr_FR.tar.gz

RUN rm /var/www/html/index.nginx-debian.html

# phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-4.9.4-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.4-all-languages /var/www/html/phpMyAdmin/
RUN rm phpMyAdmin-4.9.4-all-languages.tar.gz && rm /var/www/html/phpMyAdmin/config.sample.inc.php

ADD ./srcs/wp-config.php ./var/www/html/wordpress/wp-config.php
ADD ./srcs/default ./etc/nginx/sites-available/default
ADD ./srcs/php_my_config.inc.php ./var/www/html/phpMyAdmin/php_my_config.inc.php
RUN rm var/www/html/wordpress/wp-config-sample.php

# SSL
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/certs/localhost.pem -keyout /etc/ssl/certs/localhost.key -subj "/C=FR/ST=75/L=Paris/O=42/OU=sachouam/CN=localhost"

EXPOSE 80 443

CMD service mysql start && service php7.3-fpm start && service nginx start && cat
