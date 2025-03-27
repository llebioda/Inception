WP_DOWNLOAD=/tmp/wordpress.tar.gz

if [ -f $WP_DOWNLOAD ]; then
    echo "wordpress already downloaded"
    exit 0
fi

wget -q https://wordpress.org/latest.tar.gz -O $WP_DOWNLOAD
tar -xzf $WP_DOWNLOAD -C /tmp/

