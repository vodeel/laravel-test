# Use the official RHEL 8 base image
FROM docker.io/library/rockylinux:9

# Install system dependencies
RUN yum update -y && \
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-8.rpm && \
    yum module reset php -y && \
    yum install -y httpd httpd-tools unzip && \
    yum install -y @php:remi-8.2 && \
    wget https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer -O - -q | php -- --install-dir=/usr/local/bin --filename=composer  && \
    yum clean all

WORKDIR /var/www/html


# Copy the application files
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Install Laravel dependencies
RUN composer update && \
    composer install --no-interaction --optimize-autoloader

# Expose the port
EXPOSE 8000

# Start Apache server
CMD ["php artisan serve"]
