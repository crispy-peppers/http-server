FROM       ubuntu:12.04
MAINTAINER Aleksandar Diklic "https://github.com/rastasheep"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22



# http-server
RUN apt-get update
RUN apt-get -y install curl sudo git net-tools
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN npm install http-server -g
RUN node -v
RUN npm -v
WORKDIR /root
RUN id
RUN git clone https://github.com/crispy-peppers/http-server
WORKDIR /root/http-server
RUN npm i


COPY commands.sh /root/commands.sh
RUN ["chmod", "+x", "/root/commands.sh"]
ENTRYPOINT ["/root/commands.sh"]
