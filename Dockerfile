FROM php:8.3-cli-alpine

# Install system dependencies + PHP extensions
RUN apk add --no-cache \
    git \
    unzip \
    curl \
    bash \
    icu-dev \
    libzip-dev \
    oniguruma-dev \
    autoconf \
    g++ \
    make \
    && docker-php-ext-install \
       mysqli \
       pdo \
       pdo_mysql \
       intl \
       zip \
    && docker-php-ext-enable mysqli pdo pdo_mysql intl zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy app files
COPY . .

# Install PHP dependencies (if composer.json exists)
RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader; fi

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "public"]
