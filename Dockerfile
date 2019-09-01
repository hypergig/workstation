FROM ubuntu:disco
RUN apt-get update && apt-get -y install curl sudo
RUN useradd -s /bin/bash -d /home/jordan -m -G sudo jordan
RUN echo "jordan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
