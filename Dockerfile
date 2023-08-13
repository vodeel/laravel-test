# Use the official RHEL 8 base image
FROM docker.io/library/rockylinux:8-minimal

# Set environment variables
ENV APP_ENV=production \
    APP_DEBUG=false

# Install system dependencies
RUN dnf update -y && \
    dnf install -y httpd httpd-tools php php-json php-mbstring php-pdo php-xml php-pecl-zip composer unzip && \
    dnf clean all

# Copy the application files
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Install Laravel dependencies
RUN composer install --no-interaction --optimize-autoloader

# Set permissions
RUN chown -R apache:apache /var/www/html/storage /var/www/html/bootstrap/cache

# Expose the port
EXPOSE 80

# Start Apache server
CMD ["httpd", "-D", "FOREGROUND"]
