from armv7/armhf-ubuntu_core:15.04

# to run on x86
COPY files/ /
RUN [ "cross-build-start" ]

#RUN echo "deb http://ports.ubuntu.com/ubuntu-ports/ vivid universe" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends openssh-server openssh-client vim curl ca-certificates unzip && apt-get clean

# sshd setting
RUN echo 'root:sheepdog' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && echo "Port 2122" >> /etc/ssh/sshd_config

# install sun jdk8
RUN mkdir -p /usr/local/java && curl -L 'http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-arm32-vfp-hflt.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie' --insecure | tar -xz -C /usr/local/java/

EXPOSE 9200 2122 9300
RUN ["cross-build-end"]
CMD ["/bin/bash", "/root/bootstrap.sh"]
