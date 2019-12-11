FROM ubuntu:18.04

ARG TZONE='Europe/Moscow'
ENV TZONE ${TZONE}
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qy update && apt-get -qy install apt-utils busybox tcpdump nmap curl tmux python3 python3-pip postgresql-common libpq-dev
RUN pip3 install pyinstaller virtualenv bpython
RUN apt-get install -qqy --no-install-recommends tzdata
RUN echo $TZONE > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
ADD tmux.conf /etc/tmux.conf

VOLUME /opt/

ENTRYPOINT tail -f /dev/null

