# syntax=docker/dockerfile:1.4.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:sha-d1e2277-20221123T164346Z AS nvm

ARG NVM_VER=0.39.2

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VER}/install.sh | bash

# To reduce build time for a container image, separate build stages for each Node.js version and integrate them at the end.

FROM nvm AS v12

# corepackはこのコミット以後、Node.js 12では動作しない模様なので、バージョン固定する
# https://github.com/nodejs/corepack/commit/6c736c3950a8206e8f081bde477574f908df174f

COPY ./setup.bash /tmp/setup.bash
RUN NODE_VERSION=12 COREPACK_VERSION=@0.10.0 NCU_VERSION=@12.2.0 /tmp/setup.bash

FROM nvm AS v14

COPY ./setup.bash /tmp/setup.bash
RUN NODE_VERSION=14 /tmp/setup.bash

FROM nvm AS v16

COPY ./setup.bash /tmp/setup.bash
RUN NODE_VERSION=16 /tmp/setup.bash

FROM nvm AS v18

COPY ./setup.bash /tmp/setup.bash
RUN NODE_VERSION=18 /tmp/setup.bash

FROM nvm

COPY --from=v14 /home/user/.nvm/ /home/user/.nvm/
COPY --from=v16 /home/user/.nvm/ /home/user/.nvm/
# v12はcorepackのインストールを伴うため時間がかかるはずなので、最後から2番目にする
COPY --from=v12 /home/user/.nvm/ /home/user/.nvm/
# v18をデフォルトにするため、最後にコピー
COPY --from=v18 /home/user/.nvm/ /home/user/.nvm/

RUN <<_EOFEOF_ zsh
    source ~/.nvm/nvm.sh
    # install autocompletion
    # This also installs current latest pnpm by corepack
    pnpm install-completion zsh
_EOFEOF_
