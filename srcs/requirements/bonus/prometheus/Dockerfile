FROM debian:bullseye

RUN apt-get update -y --fix-missing
RUN apt-get install -y --fix-missing wget tar
RUN rm -rf /var/lib/apt/lists/*

ENV PROMETHEUS_VERSION=2.45.0

RUN wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
RUN tar -xvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz && \
    mv prometheus-${PROMETHEUS_VERSION}.linux-amd64 /opt/prometheus && \
    rm prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

WORKDIR /opt/prometheus

COPY ./conf/prometheus.yml /opt/prometheus/prometheus.yml

EXPOSE 9090

CMD [ "./prometheus", "--config.file=/opt/prometheus/prometheus.yml", "--storage.tsdb.path=/data" ]