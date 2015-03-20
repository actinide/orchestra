# ELK+NG Stack

FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

# Take care of some policy stuff to allow start/stop
RUN echo '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    chmod +x /usr/sbin/policy-rc.d

# Update and patch
RUN \
  apt-get dist-upgrade -y && \
  apt-get update && apt-get upgrade -y

# Install tools and dependencies
RUN \
  apt-get -qy install build-essential \
                      wget \
                      openjdk-7-jre-headless

# Add keys and sources
RUN \
  wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
  echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" \
  >> /etc/apt/sources.list

# Download packages
RUN \
  wget https://download.elasticsearch.org/logstash/logstash/packages/debian/logstash_1.4.2-1-2c0f5a1_all.deb && \
  wget https://download.elasticsearch.org/logstash/logstash/packages/debian/logstash-contrib_1.4.2-1-efd53ef_all.deb && \
  wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz && \
  wget https://github.com/bitly/google_auth_proxy/releases/download/v1.0/google_auth_proxy-1.0.linux-amd64.go1.3.tar.gz && \
  gunzip kibana-4.0.1-linux-x64.tar.gz && \
  tar -xvf kibana-4.0.1-linux-x64.tar && \
  gunzip google_auth_proxy-1.0.linux-amd64.go1.3.tar.gz && \
  tar -xvf google_auth_proxy-1.0.linux-amd64.go1.3.tar

# Install all the things
RUN \
  apt-get -qq update && \
  apt-get -qy install elasticsearch \
                      nginx && \
  dpkg -i logstash_1.4.2-1-2c0f5a1_all.deb && \
  dpkg -i logstash-contrib_1.4.2-1-efd53ef_all.deb

# Move package files to where they should be
RUN \
  mv ./kibana-4.0.1-linux-x64/ /opt/ && \
  ln -s /opt/kibana-4.0.1-linux-x64/ /opt/kibana && \
  mkdir /opt/google_auth_proxy && \
  mv ./google_auth_proxy-1.0.linux-amd64.go1.3/google_auth_proxy /opt/google_auth_proxy/

# Add configuration files
ADD elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
ADD elasticsearch /etc/default/elasticsearch
ADD logstash.conf /etc/logstash/conf.d/logstash.conf
ADD kibana /etc/init.d/kibana
ADD kibana.conf /etc/nginx/sites-available/kibana.conf
ADD google_auth_proxy.cfg /etc/google_auth_proxy.cfg
ADD authorizedemails.txt /opt/google_auth_proxy/authorizedemails.txt
RUN \
  ln -s /etc/nginx/sites-available/kibana.conf /etc/nginx/sites-enabled/ && \
  mkdir /var/log/nginx/kibana && \
  chmod 755 /etc/init.d/kibana

# Service management time
RUN \
  update-rc.d elasticsearch defaults 95 10 && \
  update-rc.d logstash defaults 96 10

# Configure localhost logging
ADD 30-logstash.conf /etc/rsyslog.d/30-logstash.conf

# Open for business
EXPOSE 5000 5001 514 9200 5601 4180 443

# Start services
RUN /etc/init.d/elasticsearch start
RUN /etc/init.d/logstash start
RUN /etc/init.d/rsyslog restart
RUN /etc/init.d/kibana start

# Clean up after ourselves
RUN \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Change the policy back
RUN echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d && \
    chmod +x /usr/sbin/policy-rc.d
