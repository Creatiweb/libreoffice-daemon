FROM ubuntu:xenial
MAINTAINER m.ferrero@cognitio.it
# this is image was based on https://bitbucket.org/xcgd/libreoffice/
#MAINTAINER florent.aide@gmail.com

# version 1:5.1.6~rc2-0ubuntu1~xenial4

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y -q upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y -q install libreoffice libreoffice-writer ure libreoffice-java-common libreoffice-core libreoffice-common openjdk-8-jre fonts-opensymbol hyphen-fr hyphen-de hyphen-en-us hyphen-it hyphen-ru fonts-dejavu fonts-dejavu-core fonts-dejavu-extra fonts-noto fonts-dustin fonts-f500 fonts-fanwood fonts-freefont-ttf fonts-liberation fonts-lmodern fonts-lyx fonts-sil-gentium fonts-texgyre fonts-tlwg-purisa \
    && DEBIAN_FRONTEND=noninteractive apt-get -q -y autoremove libreoffice-gnome \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*
  
EXPOSE 8100

RUN adduser --home=/opt/libreoffice --disabled-password --gecos "" --shell=/bin/bash libreoffice

# replace default setup with a one disabling logos by default
ADD sofficerc /etc/libreoffice/sofficerc
ADD startoo.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/startoo.sh

ENTRYPOINT ["/usr/local/bin/startoo.sh"]
