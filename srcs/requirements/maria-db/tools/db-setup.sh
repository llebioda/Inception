mysqld_safe --datadir=/var/lib/mysql &

echo "Waiting for maria-db to start..."
until mysqladmin ping -u root --silent; do
    sleep 1
done

mysql -u root -p"$DB_ROOT_PASS" -e "
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
CREATE USER IF NOT EXISTS 'root'@'adminer.inception' IDENTIFIED BY '$DB_ROOT_PASS';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'adminer.inception' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

mysqladmin -u root -p"$DB_ROOT_PASS" shutdown

mysqld