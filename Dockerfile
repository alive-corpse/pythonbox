FROM ubuntu:18.04

ARG TZONE='Europe/Moscow'
ENV TZONE ${TZONE}

RUN apt-get -qy update && DEBIAN_FRONTEND=noninteractive apt-get -qy install apt-utils busybox tcpdump nmap curl tmux python3 python3-pip postgresql-common libpq-dev tzdata
RUN pip3 install pyinstaller virtualenv bpython
RUN dpkg-reconfigure -f noninteractive tzdata
RUN ln -snf /usr/share/zoneinfo/$TZONE /etc/localtime
RUN echo $TZONE > /etc/timezone
ADD tmux.conf /etc/tmux.conf

VOLUME /opt/

ENTRYPOINT tail -f /dev/null

