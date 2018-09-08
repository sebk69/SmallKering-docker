FROM php:7.2-fpm
WORKDIR "/server"

RUN echo "date.timezone = Europe/Paris" > /usr/local/etc/php/conf.d/timezone.ini

# Install selected extensions and other stuff
RUN docker-php-ext-install pdo pdo_mysql

COPY php-ini-overrides.ini /usr/local/etc/php/conf.d/99-overrides.ini

# Install sudo
RUN apt-get update \
    && apt-get -y install sudo \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install git
RUN apt-get update \
    && apt-get -y install git \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install zip
RUN apt-get update \
    && apt-get -y install zip unzip \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install openssl
RUN apt-get update \
    && apt-get -y install sshpass openssl \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install wkhtmltopdf
COPY keyboard /etc/default/keyboard
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq install wkhtmltopdf xorg xvfb \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
COPY wkhtmltopdf.sh /usr/bin/wkhtmltopdf.sh
RUN chmod 755 /usr/bin/wkhtmltopdf.sh

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# create user
RUN groupadd keys
RUN useradd -r -u 1000 -g keys keys
RUN usermod -a -G sudo keys
RUN mkdir /home/keys
RUN chown keys:keys /home/keys
RUN echo "dev\ndev" | passwd
USER keys