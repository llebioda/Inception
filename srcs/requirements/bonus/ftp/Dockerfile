FROM debian:bullseye

RUN apt-get update -y --fix-missing
RUN apt-get install -y --fix-missing vsftpd ftp
RUN rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

COPY ./tools/ftp-setup.sh /usr/local/bin/ftp-setup.sh
RUN chmod +x /usr/local/bin/ftp-setup.sh

RUN mkdir -p /var/run/vsftpd/empty && chmod 755 /var/run/vsftpd/empty

EXPOSE 21

CMD [ "bash", "/usr/local/bin/ftp-setup.sh" ]
