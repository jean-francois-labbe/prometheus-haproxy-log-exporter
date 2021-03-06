FROM debian

RUN apt-get update && apt-get install -y python3
RUN apt-get install -y build-essential
RUN apt-get install -y python3-pip
RUN pip3 install tailhead

ADD . /haproxy_log_exporter
WORKDIR /haproxy_log_exporter
RUN apt-get build-dep -y  .
RUN dpkg-buildpackage
RUN dpkg -i /prometheus-haproxy-log-exporter_0.1_all.deb; apt-get -f -y install && dpkg -i /prometheus-haproxy-log-exporter_0.1_all.deb

ENTRYPOINT ["/usr/bin/prometheus-haproxy-log-exporter"]
