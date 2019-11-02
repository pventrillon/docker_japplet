FROM ubuntu:14.04

MAINTAINER Philippe Ventrillon

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/firefox && \
    echo "firefox:x:${uid}:${gid}:firefox,,,:/home/firefox:/bin/bash" >> /etc/passwd && \
    echo "firefox:x:${uid}:" >> /etc/group && \
    echo "firefox ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/firefox && \
    chmod 0440 /etc/sudoers.d/firefox && \
    chown ${uid}:${gid} -R /home/firefox

ADD https://ftp.mozilla.org/pub/firefox/releases/52.9.0esr/linux-x86_64/en-US/firefox-52.9.0esr.tar.bz2 /tmp
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y \
    libgtk-3-0 libdbus-glib-1-2 libXt6 libx11-xcb1 \
    openjdk-7-jre icedtea-plugin && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/* && \
    tar -C /usr/bin -xvjf /tmp/firefox-52.9.0esr.tar.bz2

ENV HOME /home/firefox
WORKDIR /home/firefox
COPY --chown=firefox:firefox rsc/* ${HOME}/

USER firefox
#CMD launch_firefox.sh "http://192.168.0.7"
ENTRYPOINT ["./launch_firefox.sh"]

