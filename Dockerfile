FROM ubuntu

# File Author / Maintainer
MAINTAINER  wtoorren
WORKDIR /data/SolidInvoice
# Update the repository sources list
RUN apt-get update; apt-get clean

# Install and run apache
RUN apt-get install -y apache2 vim wget  apt-utils
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install tzdata curl
RUN apt-get install -y php git
RUN apt-get install -y libapache2-mod-php php-mysql
RUN apt-get install -y php-gd php-intl php-soap php-xsl php-zip php-mbstring php-curl php-symfony
RUN apt-get clean

# PHP composer

RUN git clone https://github.com/SolidInvoice/SolidInvoice.git /data/SolidInvoice
RUN curl -o /data/SolidInvoice/composer.phar http://getcomposer.org/installer
RUN php composer.phar --no-plugins allow-plugins.symfony/flex true
#RUN php composer.phar --no-plugins allow-plugins.phpstan/extension-installer
RUN php composer.phar require symfony/flex --no-plugins --no-scripts
#RUN php composer.phar update --no-interaction -W
#RUN (cd /data/SolidInvoice ; php composer.phar install)
#RUN npm uninstall node-sass --silent
#RUN rm -fr /data/SolidInvoice /data/SolidInvoice/node_modules package-lock.json
#RUN npm install --silent
#RUN ln -s 
EXPOSE 80
COPY vhosts.soi.conf /etc/apache2/sites-available/000-default.conf
COPY dir.conf /etc/apache2/mods-enabled/dir.conf
#RUN a2enmod php 
RUN a2enmod rewrite
CMD apachectl -D FOREGROUND