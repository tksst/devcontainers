# syntax=docker/dockerfile:1.4.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:main@sha256:c587ca1c6ccad5ad1586c84e373f3ce031ec1c5388dd2f1a3cce6b5bccb0113f AS nvm

ARG NVM_VER=v0.39.7

RUN \
    --mount=type=cache,target=/var/lib/apt/lists \
    --mount=type=cache,target=/var/cache/apt \
    <<'_EOFEOF_' bash

    set -eu
    set -o posix
    set -o pipefail

    if [[ $(arch) != "x86_64" && $(arch) != "aarch64" ]]; then
        sudo apt-get update
        DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --no-install-recommends libatomic1
    fi

    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VER}/install.sh | bash

_EOFEOF_

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
        echo 'export PATH="$DENO_INSTALL/bin:$PATH"'
    } >> ~/.zshrc
_EOFEOF_
