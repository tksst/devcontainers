# syntax=docker/dockerfile:1.4.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:sha-0bc6656-20220904T090626Z AS nvm

ARG NVM_VER=0.39.1

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VER}/install.sh | bash

FROM nvm AS v12

# corepackはこのコミット以後、Node.js 12では動作しない模様なので、バージョン固定する
# https://github.com/nodejs/corepack/commit/6c736c3950a8206e8f081bde477574f908df174f
RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install 12
    npm install -g corepack@0.10.0
    npm uninstall -g npm
    # Enable corepack itself and also enable npm
    corepack enable npm
    npm install -g npm-check-updates@12.2.0 0x
_EOFEOF_

FROM nvm AS v14

RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install 14
    # Upgrade npm to use for corepack updates (although it will be turned off soon)
    npm install -g npm
    # Upgrade corepack
    npm install -g corepack
    npm uninstall -g npm
    # Enable corepack itself and also enable npm
    corepack enable npm
    npm install -g npm-check-updates 0x
_EOFEOF_

FROM nvm AS v16

RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install 16
    # Upgrade corepack
    npm install -g corepack
    npm uninstall -g npm
    # Enable corepack itself and also enable npm
    corepack enable npm
    npm install -g npm-check-updates 0x
_EOFEOF_

FROM nvm AS v18

RUN <<_EOFEOF_ zsh
    set -eu
    . $HOME/.nvm/nvm.sh
    nvm install 18
    # Upgrade corepack
    npm install -g corepack
    npm uninstall -g npm
    # Enable corepack itself and also enable npm
    corepack enable npm
    npm install -g npm-check-updates 0x
    rm -rf ~/.npm
_EOFEOF_

COPY --from=v14 /home/user/.nvm/ /home/user/.nvm/
# v12はcorepackのインストールを伴うため時間がかかるはずなので、2番目にする
COPY --from=v12 /home/user/.nvm/ /home/user/.nvm/
# v16をデフォルトにするため、最後にコピー
COPY --from=v16 /home/user/.nvm/ /home/user/.nvm/
