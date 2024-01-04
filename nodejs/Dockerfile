# syntax=docker/dockerfile:1.4.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:sha-074324c-20231217T091344Z AS nvm

ARG NVM_VER=0.39.7

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

    set -eu
    set -o pipefail

    ## pnpm autocompletion
    source ~/.nvm/nvm.sh
    # install autocompletion
    # This also installs current latest pnpm by corepack
    pnpm install-completion zsh

    ## Bun
    curl -fsSL https://bun.sh/install | bash

    ## Deno
    curl -fsSL https://deno.land/x/install/install.sh | sh
    {
        echo 'export DENO_INSTALL="/home/user/.deno"'
        echo 'export PATH="$DENO_INSTALL/bin:$PATH"'
    } >> ~/.zshrc
_EOFEOF_
