FROM ubuntu:disco
ENV DEBIAN_FRONTEND=noninteractive

# separate layers to speed up testing
RUN apt-get update
RUN apt-get -y install ubuntu-desktop
RUN apt-get -y install curl sudo

RUN useradd -s /bin/bash -d /home/jordan -m -G sudo jordan && \
    echo "jordan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    rm -v /etc/apt/apt.conf.d/docker-clean
