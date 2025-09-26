# Use Alpine-based PHP 8.3 CLI image
FROM php:8.3-cli-alpine

# Install required system packages and PHP extensions
RUN apk update && apk add --no-cache \
        git \
        unzip \
        curl \
        bash \
        libpng-dev \
        libjpeg-turbo-dev \
        libzip-dev \
        oniguruma-dev \
        icu-dev \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        mysqli \
        mbstring \
        zip \
        intl \
        gd

# Install Composer globally
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --no-plugins --no-scripts --prefer-dist

# Expose port 80
EXPOSE 80

# Start PHP built-in server (for dev/testing)
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
