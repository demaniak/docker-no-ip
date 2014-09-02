# The config file is named duck.conf, and has the format:
# DOMAINS=<your domain>
# TOKEN=<your token>
# INVERVAL=<update period. e.g. "5m" or "1h">

# Output will be written to /config/duck.log

FROM phusion/baseimage:0.9.11

MAINTAINER coppit

VOLUME ["/config"]

ADD noip-duc-linux.tar.gz /root/

# Do it this way to avoid creating a useless 100+ MB layer for the user to download
RUN apt-get update && \
  apt-get install -y make gcc && \
  cd /root/noip-2.1.9-1 && \
  make && \
  mv noip2 /root && \
  cd /root && \
  rm -rf /root/noip-2.1.9-1 && \
  apt-get remove -y make gcc && \
  apt-get autoremove -y && \
  apt-get autoclean -y

#RUN yum install -y make gcc && \
#  cd /root/noip-2.1.9.1 && \
#  make && \
#  mv noip2 /root && \
#  cd /root && \
#  rm -rf /root/noip-2.1.9.1 && \
#  yum history undo 3 -y

ADD noip.sh /root/

CMD /bin/bash -c '/root/noip.sh'
