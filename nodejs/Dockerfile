# syntax=docker/dockerfile:1.2.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:sha-7bc75c7-20220507T162401Z

ARG NVM_VER=0.39.1

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VER}/install.sh | bash
RUN echo npm-check-updates >> ~/.nvm/default-packages

ARG NPM_VER=8.10.0

ARG NODE16_VER=16.15.0

# nvm.sh requires bash
RUN bash -c '. $HOME/.nvm/nvm.sh \
&& nvm install ${NODE16_VER} --latest-npm \
&& corepack enable npm yarn pnpm \
&& corepack prepare --activate npm@${NPM_VER} \
'

ARG NODE14_VER=14.19.3

RUN bash -c '. $HOME/.nvm/nvm.sh \
&& nvm install ${NODE14_VER} --latest-npm \
&& corepack enable npm yarn pnpm \
&& corepack prepare --activate npm@${NPM_VER} \
'

ARG NODE18_VER=18.2.0

RUN bash -c '. $HOME/.nvm/nvm.sh \
&& nvm install ${NODE18_VER} --latest-npm \
&& corepack enable npm yarn pnpm \
&& corepack prepare --activate npm@${NPM_VER} \
'

ARG NODE12_VER=12.22.12

RUN bash -c '. $HOME/.nvm/nvm.sh \
&& nvm install ${NODE12_VER} --latest-npm \
&& npm install -g corepack \
&& corepack enable npm yarn pnpm \
&& corepack prepare --activate npm@${NPM_VER} \
'
