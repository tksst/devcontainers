# syntax=docker/dockerfile:1.2.1

FROM ubuntu:jammy-20220421

# /etc/apt/apt.conf.d/docker-clean disables /var/cache/apt/archives caching
# so disabled temporarily

RUN \
--mount=type=cache,target=/var/lib/apt/lists \
--mount=type=cache,target=/var/cache/apt \
--mount=type=cache,target=/tmp/packages \
mv /etc/apt/apt.conf.d/docker-clean / \
&& yes | unminimize \
&& ZSHCONFIGDEB=tksst-zsh-config_1.0.0-1_all.deb \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
language-pack-ja \
git \
lsof \
vim \
less \
strace \
jq \
gnupg2 \
zsh \
zsh-autosuggestions \
zsh-syntax-highlighting \
openssh-client \
curl \
wget \
man \
manpages \
sudo \
openssl \
unzip \
tzdata \
ca-certificates \
file \
bind9-dnsutils \
iputils-ping \
bzip2 \
xz-utils \
zstd \
&& cd /tmp/packages \
&& wget -q -N "https://github.com/tksst/zsh-config/releases/download/v1.0.0/${ZSHCONFIGDEB}" \
&& apt-get install -y ./${ZSHCONFIGDEB} \
&& mv /docker-clean /etc/apt/apt.conf.d/

# AWS CLI
# FIXME: amd64 specific
RUN \
--mount=type=cache,target=/tmp/packages \
--mount=type=tmpfs,target=/tmp/tmp \
cd /tmp/packages \
&& wget -N "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
&& cd /tmp/tmp \
&& unzip -q /tmp/packages/awscli-exe-linux-x86_64.zip \
&& ./aws/install

# 日本時間
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ARG USER=user

# 一般ユーザ作成
RUN useradd -m -s /usr/bin/zsh ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${USER}

USER ${USER}
RUN echo "source /opt/tksst/zsh/zshrc_tksst" >> /home/${USER}/.zshrc

ENV LANG=ja_JP.UTF-8
WORKDIR /home/${USER}
CMD [ "zsh" ]


