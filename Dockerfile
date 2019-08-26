FROM node:10-stretch

# AWS cli
RUN apt-get update \
  && apt-get -y install gnupg2 git wget gawk apt-transport-https ca-certificates curl software-properties-common python python-pip \
  && curl -O https://bootstrap.pypa.io/get-pip.py \
  && python get-pip.py \
  && pip install awscli --upgrade --user \
  && export PATH=$PATH:/root/.local/bin

# docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-cache policy docker-ce \
  && apt-get -y install docker-ce

# git-secret
RUN echo "deb https://dl.bintray.com/sobolevn/deb git-secret main" | tee -a /etc/apt/sources.list \
  && wget -qO - https://api.bintray.com/users/sobolevn/keys/gpg/public.key | apt-key add - \
  && apt-get update \
  && apt-get install -y git-secret
