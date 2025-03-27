PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION;")

# set the listen port to 9000
PHP_FPM_CONF="/etc/php/$PHP_VERSION/fpm/pool.d/www.conf"

if grep -q "^listen =" $PHP_FPM_CONF; then
   sed -i "s|^listen = .*|listen = 0.0.0.0:9000|" $PHP_FPM_CONF
else
   echo "listen = 0.0.0.0:9000" >> $PHP_FPM_CONF
fi

# wordpress setup
WP_DIR="/var/www/html"
WP_CONFIG=$WP_DIR/wp-config.php

if [ -f $WP_CONFIG ]; then
    echo "wordpress already configured"
else
    mkdir -p $WP_DIR
    rm -rf $WP_DIR/*

    cp -r /tmp/wordpress/* $WP_DIR
    chown -R www-data:www-data $WP_DIR
    chmod -R 755 $WP_DIR
fi

cp $WP_DIR/wp-config-sample.php $WP_CONFIG
wp config set DB_NAME $DB_NAME --allow-root
wp config set DB_USER $DB_USER --allow-root
wp config set DB_PASSWORD $DB_PASS --allow-root
wp config set DB_HOST maria-db --allow-root

##redis
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root
wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
wp config set WP_REDIS_CLIENT phpredis --allow-root

echo "Waiting for the database to be ready..."
until mysqladmin ping -h maria-db --port 3306 --silent; do
    sleep 1
done
echo "Database is ready!"

if [ -d /var/www/html/wp-content/plugins/redis-cache ]; then
    echo "Redis plugin is already installed."
else
    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
    wp redis enable --allow-root
fi
##end of redis

/usr/sbin/php-fpm$PHP_VERSION -F