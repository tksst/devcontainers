# syntax=docker/dockerfile:1.4.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:sha-a5199ee-20220613T103632Z

ARG NVM_VER=0.39.1

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VER}/install.sh | bash

ARG NPM_VER=8.13.1

ARG NODE16_VER=16.15.1

RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install ${NODE16_VER}
    npm uninstall -g npm
    corepack enable npm yarn pnpm
    corepack prepare --activate npm@${NPM_VER}
    npm install -g npm-check-updates
_EOFEOF_

ARG NODE14_VER=14.19.3

RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install ${NODE14_VER}
    npm uninstall -g npm
    corepack enable npm yarn pnpm
    corepack prepare --activate npm@${NPM_VER}
    npm install -g npm-check-updates
_EOFEOF_

ARG NODE18_VER=18.4.0

RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install ${NODE18_VER}
    npm uninstall -g npm
    corepack enable npm yarn pnpm
    corepack prepare --activate npm@${NPM_VER}
    npm install -g npm-check-updates
_EOFEOF_

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
