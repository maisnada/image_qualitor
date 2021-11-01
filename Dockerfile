FROM php:7.4.8-apache-buster

EXPOSE 80

ENV ACCEPT_EULA=Y
RUN apt-get update && apt-get install -y gnupg2 git
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 
RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list 
RUN apt-get update 
RUN ACCEPT_EULA=Y apt-get -y --no-install-recommends install msodbcsql17 unixodbc-dev mssql-tools telnet
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

WORKDIR /var/www/html

RUN git clone --single-branch --branch prod https://update:7urG9SYdpif3z6qqzTMm@gitlab.com/QualitorPHP/qualitor/8.20.git /var/www/html

COPY index.php /var/www/html
COPY temp /var/www/html
COPY modules /var/www/html/gtw/modules
COPY config.php /var/www/html/framework/conexao