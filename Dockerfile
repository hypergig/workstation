FROM ubuntu:disco
RUN apt update && apt -y install curl sudo
RUN useradd -s /bin/bash -d /home/jordan -m -G sudo jordan
RUN echo "jordan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
