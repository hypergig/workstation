FROM ubuntu:disco
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install curl ubuntu-desktop sudo
RUN useradd -s /bin/bash -d /home/jordan -m -G sudo jordan
RUN echo "jordan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# RUN echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/01keep-debs
RUN rm -v /etc/apt/apt.conf.d/docker-clean
