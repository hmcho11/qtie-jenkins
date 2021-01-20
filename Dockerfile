FROM jenkins/jenkins:latest
LABEL maintainer="hmcho <hyem.cho@gmail.com>"

USER root

# install Node, wget
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs wget

# install Docker
RUN apt-get update

RUN apt-get install -y\
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update -y
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

# install Development Tools# Using Debian
RUN apt install -y build-essential

#install gvm, go
RUN apt-get install -y git mercurial make binutils bison gcc build-essential
RUN bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
RUN source /root/.gvm/scripts/gvm
RUN gvm install go1.14.4 -B
RUN gvm use go1.14.4 --default

# install Grunt, node-gyp
RUN npm install -g grunt node-gyp

# install jq
RUN apt-get install jq -y

RUN apt-get clean -y

WORKDIR /var/jenkins_home

