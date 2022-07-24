# syntax=docker/dockerfile:1.4.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:sha-1d31d12-20220724T134246Z AS nvm

ARG NVM_VER=0.39.1

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VER}/install.sh | bash

ARG NPM_VER=8.15.0

FROM nvm AS v12
ARG NODE12_VER=12.22.12

# corepackはこのコミット以後、Node.js 12では動作しない模様なので、バージョン固定する
# https://github.com/nodejs/corepack/commit/6c736c3950a8206e8f081bde477574f908df174f
RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install ${NODE12_VER}
    npm install -g corepack@0.10.0
    npm uninstall -g npm
    corepack enable npm yarn pnpm
    corepack prepare --activate npm@${NPM_VER}
    npm install -g npm-check-updates@12.2.0
_EOFEOF_

FROM nvm AS v14
ARG NODE14_VER=14.20.0

RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install ${NODE14_VER}
    # Upgrade npm to use for corepack updates (although it will be turned off soon)
    npm install -g npm@${NPM_VER}
    # Upgrade corepack
    npm install -g corepack
    npm uninstall -g npm
    corepack enable npm yarn pnpm
    corepack prepare --activate npm@${NPM_VER}
    npm install -g npm-check-updates
_EOFEOF_

FROM nvm AS v16
ARG NODE16_VER=16.16.0

RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install ${NODE16_VER}
    # Upgrade corepack
    npm install -g corepack
    npm uninstall -g npm
    corepack enable npm yarn pnpm
    corepack prepare --activate npm@${NPM_VER}
    npm install -g npm-check-updates
_EOFEOF_

FROM nvm AS v18
ARG NODE18_VER=18.6.0

RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install ${NODE18_VER}
    # Upgrade corepack
    npm install -g corepack
    npm uninstall -g npm
    corepack enable npm yarn pnpm
    corepack prepare --activate npm@${NPM_VER}
    npm install -g npm-check-updates
    rm -rf ~/.npm
_EOFEOF_

COPY --from=v14 /home/user/.nvm/ /home/user/.nvm/
# v12はcorepackのインストールを伴うため時間がかかるはずなので、2番目にする
COPY --from=v12 /home/user/.nvm/ /home/user/.nvm/
# v16をデフォルトにするため、最後にコピー
COPY --from=v16 /home/user/.nvm/ /home/user/.nvm/
