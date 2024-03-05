# syntax=docker/dockerfile:1.4.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:main@sha256:7ce8d2e557b1b5a2a20eaf80142d3b88350679210bd28684c3e9ff712a73fc3e AS nvm

ARG NVM_VER=v0.39.7

RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VER}/install.sh | bash

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

RUN <<'_EOFEOF_' zsh

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
        echo '# Deno'
        echo 'export DENO_INSTALL="/home/user/.deno"'
        echo 'export PATH="\$DENO_INSTALL/bin:\$PATH"'
    } >> ~/.zshrc
_EOFEOF_
