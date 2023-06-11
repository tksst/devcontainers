# syntax=docker/dockerfile:1.4.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:sha-0783b4e-20230521T051349Z AS nvm

ARG NVM_VER=0.39.3

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VER}/install.sh | bash

# To reduce build time for a container image, separate build stages for each Node.js version and integrate them at the end.

FROM nvm AS v16

COPY ./setup.bash /tmp/setup.bash
RUN NODE_VERSION=16 /tmp/setup.bash

FROM nvm AS v18

COPY ./setup.bash /tmp/setup.bash
RUN NODE_VERSION=18 /tmp/setup.bash

FROM nvm AS v20

COPY ./setup.bash /tmp/setup.bash
RUN NODE_VERSION=20 /tmp/setup.bash

FROM nvm

COPY --from=v16 /home/user/.nvm/ /home/user/.nvm/
COPY --from=v20 /home/user/.nvm/ /home/user/.nvm/
# v18をデフォルトにするため、最後にコピー
COPY --from=v18 /home/user/.nvm/ /home/user/.nvm/

# avoid corepack + npm >= 9.7.0 bug
RUN mkdir -p /home/user/.cache/node/corepack/
COPY --from=v18 /home/user/.cache/node/corepack/ /home/user/.cache/node/corepack/

RUN <<_EOFEOF_ zsh
    source ~/.nvm/nvm.sh
    # install autocompletion
    # This also installs current latest pnpm by corepack
    pnpm install-completion zsh
_EOFEOF_
