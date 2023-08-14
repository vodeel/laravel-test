# Use the official RHEL 8 base image
FROM docker.io/library/rockylinux:8.8

# Install system dependencies
RUN yum update -y && \
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-8.rpm && \
    yum module reset php  -y && \
    yum install -y wget httpd unzip && \
    yum install -y @php:remi-8.2 && \
    wget https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer -O - -q | php -- --install-dir=/usr/local/bin --filename=composer  && \
    yum clean all

WORKDIR /lapp
# Copy the application files
COPY . /lapp
RUN composer install && \
    chmod -R 777 storage &&  chmod -R 777 bootstrap/cache && \
    cp .env.example .env && php artisan key:generate
# Expose the port
EXPOSE 80

# Start Apache server
CMD  php artisan serve --host=0.0.0.0 --port=80
