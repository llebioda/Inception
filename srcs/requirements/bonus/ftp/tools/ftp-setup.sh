useradd -m -d /home/$FTP_USER -s /bin/bash $FTP_USER
echo "$FTP_USER:$FPT_PWD" | chpasswd
mkdir -p /var/www/html
chown -R $FTP_USER:$FTP_USER /var/www/html

/usr/sbin/vsftpd /etc/vsftpd.conf