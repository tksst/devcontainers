# syntax=docker/dockerfile:1.6.0@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021
FROM ghcr.io/tksst/devcontainers/devcontainer-base:sha-65e439a-20231014T092956Z AS nvm

ARG NVM_VER=0.39.5

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VER}/install.sh | bash

# To reduce build time for a container image, separate build stages for each Node.js version and integrate them at the end.

FROM nvm AS v18

COPY ./setup.bash /tmp/setup.bash
RUN NODE_VERSION=18 /tmp/setup.bash

FROM nvm AS v20

COPY ./setup.bash /tmp/setup.bash
RUN NODE_VERSION=20 /tmp/setup.bash

FROM nvm

COPY --from=v18 /home/user/.nvm/ /home/user/.nvm/
# v20をデフォルトにするため、最後にコピー
COPY --from=v20 /home/user/.nvm/ /home/user/.nvm/

RUN <<_EOFEOF_ zsh
    source ~/.nvm/nvm.sh
    # install autocompletion
    # This also installs current latest pnpm by corepack
    pnpm install-completion zsh
_EOFEOF_
