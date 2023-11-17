# syntax=docker/dockerfile:1.6.0@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021

FROM ubuntu:jammy@sha256:2b7412e6465c3c7fc5bb21d3e6f1917c167358449fecac8176c6e496e5c1f05f

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
    ZSHCONFIGDEB=tksst-zsh-config_1.2.0-1_all.deb 

    # set up the latest stable upstream Git repository
    apt-get install -y software-properties-common
    add-apt-repository -y ppa:git-core/ppa

    # set up docker client repository
    apt-get install -y lsb-release curl
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg > /etc/apt/keyrings/docker.asc
    echo "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

    # set up the GitHub CLI repository
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg > /etc/apt/keyrings/githubcli-archive-keyring.gpg
    echo "deb [signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list

    apt-get update

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
    sysstat \
    shellcheck \

    # install docker client from docker-ce
    DEBIAN_FRONTEND=noninteractive apt-get -y install docker-ce-cli docker-compose-plugin

    # install GitHub CLI
    DEBIAN_FRONTEND=noninteractive apt-get -y install gh
    gh completion -s zsh > /usr/local/share/zsh/site-functions/_gh

    # install my zsh config
    cd /tmp/packages
    wget -q -N "https://github.com/tksst/zsh-config/releases/download/v1.2.0/${ZSHCONFIGDEB}"
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

# actionlint
RUN <<_EOFEOF_
    set -eu
    cd /usr/local/bin
    ACTIONLINT_SCRIPT_REVISION=d0dbdb7f1fd55f2c2b0a0e8243ba6ae2100bb02f # A little newer than version 1.6.26
    curl https://raw.githubusercontent.com/rhysd/actionlint/${ACTIONLINT_SCRIPT_REVISION}/scripts/download-actionlint.bash | bash
_EOFEOF_

# 日本時間
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# ミラーサイトを日本の理研にする
COPY ./mirrors.txt /etc/apt/
RUN perl -pe 's!(?<=deb(?:-src)?\s)http://archive.ubuntu.com/ubuntu/(?=\s)!mirror+file:/etc/apt/mirrors.txt!g' -i /etc/apt/sources.list

ARG USER=user

# 一般ユーザ作成
RUN useradd -m -s /usr/bin/zsh ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${USER}

USER ${USER}

RUN <<_EOFEOF_
    persistent_dir=/home/${USER}/persistent
    mkdir -p $persistent_dir
    {
        echo "source /opt/tksst/zsh/zshrc_tksst"
        echo "export HISTFILE=${persistent_dir}/.zsh_history"
    } >> /home/${USER}/.zshrc
_EOFEOF_

# AWS CLI completion
RUN echo "autoload -Uz bashcompinit && bashcompinit && complete -C '/usr/local/bin/aws_completer' aws" >> /home/${USER}/.zshrc

# SSH ControlMaster
ARG SSH_CONTROL_PERSIST=30m
COPY --chown=${USER} <<_EOFEOF_ /home/${USER}/.ssh/config
ControlMaster auto
ControlPath ~/.ssh/mux-%r@%h:%p
ControlPersist ${SSH_CONTROL_PERSIST}
ServerAliveInterval 295
ServerAliveCountMax 6
_EOFEOF_

ENV LANG=ja_JP.UTF-8
WORKDIR /home/${USER}
CMD [ "zsh" ]
