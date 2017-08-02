# based on jaysonsantos/docker-minecraft-ftb-skyfactory3

FROM java:8

MAINTAINER example@example.com

ENV VERSION=1.4

RUN apt-get update && apt-get install -y wget unzip
RUN adduser --disabled-password --home=/data --uid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/ftb && cd /tmp/ftb && \
	wget -c https://addons-origin.cursecdn.com/files/2455/958/gangzcraft-server-1.4.zip -O gangz.zip && \
	unzip gangz.zip && \
	chown -R minecraft /tmp/ftb

USER minecraft

EXPOSE 25565

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start

ENV MOTD Gangzcraft ${VERSION} GRIND on docker
ENV LEVEL world
ENV JVM_OPTS -Xms4096m -Xmx4096m
