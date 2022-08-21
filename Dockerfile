FROM ubuntu

# File Author / Maintainer
MAINTAINER  wtoorren

# Update the repository sources list
RUN apt-get update; apt-get clean

# Install and run apache
RUN apt-get install -y apache2 vim wget  apt-utils
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install tzdata curl
RUN apt-get install -y php git
RUN apt-get install -y libapache2-mod-php php-mysql
RUN apt-get clean

# PHP composer
RUN curl -sS http://getcomposer.org/installer | php
RUN git clone https://github.com/SolidInvoice/SolidInvoice.git
#4RUN cd SolidInvoice
#RUN php composer.phar create-project solidinvoice/solidinvoice
# RUN npm install
# RUN ./node_modules/.bin/gulp
#ENTRYPOINT ["/usr/sbin/apache2", "-k", "start"]


#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80
COPY vhosts.soi.conf /etc/apache2/sites-available/000-default.conf
COPY dir.conf /etc/apache2/mods-enabled/dir.conf
#RUN a2enmod php 
RUN a2enmod rewrite

# PHP COMPOSE
#RUN curl -sS http://getcomposer.org/installer | php
# RUN php composer.phar
#RUN php composer.phar create-project solidinvoice/solidinvoice
#RUN npm install
#RUN ./node_modules/.bin/gulp
CMD apachectl -D FOREGROUND