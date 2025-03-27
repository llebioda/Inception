ADMINER_PHP="/var/www/html/index.php"

rm -rf /var/www/html/*

wget "https://www.adminer.org/latest.php" -O $ADMINER_PHP
chown -R www-data:www-data $ADMINER_PHP
chmod -R 755 $ADMINER_PHP

php -S 0.0.0.0:8080 -t /var/www/html