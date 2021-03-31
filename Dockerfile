FROM ubuntu:latest
MAINTAINER Asif J (asif.h.j@gmail.com)

WORKDIR /root

RUN apt-get update
RUN apt-get -y install curl git jq

# Download the nodesource PPA for Node.js
RUN curl https://deb.nodesource.com/setup_12.x | bash


# Download the Yarn repository configuration
# See instructions on https://legacy.yarnpkg.com/en/docs/install/
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Update Ubuntu
RUN apt update
RUN apt upgrade -y

# Install Node.js, Yarn, and build tools
# Install jq for formatting of JSON data
RUN apt install nodejs=12.* yarn build-essential jq -y


# First remove any existing old Go installation
RUN rm -rf /usr/local/go

# Install correct Go version
RUN curl https://dl.google.com/go/go1.15.7.linux-amd64.tar.gz | tar -C/usr/local -zxvf -

RUN git clone https://github.com/Agoric/agoric-sdk -b @agoric/sdk@2.14.0 


# Update environment variables to include go
RUN cat <<'EOF' >>$HOME/.profile
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/go
ENV GO111MODULE=on
ENV PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
RUN /bin/bash -c "source $HOME/.profile"

RUN cd agoric-sdk && yarn install && yarn build && (cd packages/cosmic-swingset && make)

#RUN mv /root/.ag-chain-cosmos /root/.ag-chain-cosmos-bk
COPY startup.sh /root

CMD ["/bin/bash", "/root/startup.sh"]