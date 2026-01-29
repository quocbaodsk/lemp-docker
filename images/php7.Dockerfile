FROM php:7.4-fpm-alpine

# Use production config by default
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Install dependencies
RUN apk add --no-cache \
    curl \
    zip \
    unzip \
    libzip-dev \
    oniguruma-dev \
    icu-dev \
    freetype \
    libjpeg-turbo \
    libpng \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev

# Setup GD extension
RUN docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install PHP extensions
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    zip \
    bcmath \
    intl \
    mbstring

# Clean up build dependencies
RUN apk del --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    && rm -rf /tmp/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Create system user to run Composer and Artisan Commands
RUN addgroup -g 1000 www && \
    adduser -u 1000 -G www -h /home/www -D www

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 \
    CMD php-fpm -t || exit 1

# Set working directory
WORKDIR /var/www/html

CMD ["php-fpm"]