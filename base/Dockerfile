# syntax=docker/dockerfile:1.4.1

FROM ubuntu:jammy-20220801

# /etc/apt/apt.conf.d/docker-clean disables /var/cache/apt/archives caching
# so disabled temporarily

RUN \
--mount=type=tmpfs,target=/var/lib/apt/lists \
--mount=type=tmpfs,target=/var/cache/apt \
--mount=type=tmpfs,target=/tmp/packages \
<<_EOFEOF_
    set -eu
    mv /etc/apt/apt.conf.d/docker-clean /
    yes | unminimize
    ZSHCONFIGDEB=tksst-zsh-config_1.0.0-1_all.deb

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
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
    uuid-runtime \
    rsync \
    apt-file \
    nano \
    iproute2 \
    socat \

    cd /tmp/packages
    wget -q -N "https://github.com/tksst/zsh-config/releases/download/v1.0.0/${ZSHCONFIGDEB}"
    apt-get install -y ./${ZSHCONFIGDEB}
    mv /docker-clean /etc/apt/apt.conf.d/
_EOFEOF_

# AWS CLI
RUN \
--mount=type=tmpfs,target=/tmp/packages \
--mount=type=tmpfs,target=/tmp/tmp \
<<_EOFEOF_
    set -eu
    file=awscli-exe-linux-$(arch).zip
    cd /tmp/packages
    wget -N "https://awscli.amazonaws.com/${file}"
    cd /tmp/tmp
    unzip -q "/tmp/packages/${file}"
    ./aws/install
_EOFEOF_

# 日本時間
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# ミラーサイトを日本の理研にする
RUN perl -pe 's#^(\s*deb\s+)http://archive.ubuntu.com/ubuntu(/|\s)#$1http://ftp.riken.jp/Linux/ubuntu$2#g' -i /etc/apt/sources.list

ARG USER=user

# 一般ユーザ作成
RUN useradd -m -s /usr/bin/zsh ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${USER}

USER ${USER}
RUN echo "source /opt/tksst/zsh/zshrc_tksst" >> /home/${USER}/.zshrc

ENV LANG=ja_JP.UTF-8
WORKDIR /home/${USER}
CMD [ "zsh" ]


