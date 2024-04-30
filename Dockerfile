ARG VERSION=3.0.0

FROM ubuntu:22.04

LABEL description="An Decentralized IP Marketplace to Leave Your Limitations Behind." url="www.bura.dev"

RUN apt-get update && \
    apt-get -y install curl tar ca-certificates dos2unix sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create ubuntu user with sudo privileges
RUN useradd -ms /bin/bash ubuntu && \
    usermod -aG sudo ubuntu
# Disable sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/nopasswd

# Fix upstart
RUN rm -rf /sbin/initctl && ln -s /sbin/initctl.distrib /sbin/initctl

WORKDIR /myApp
COPY . /myApp/

USER root
RUN dos2unix /myApp/gaganode_install.sh && chmod +x /myApp/gaganode_install.sh
USER ubuntu

CMD ["/bin/bash", "-c", "/myApp/gaganode_install.sh; sleep infinity"]
