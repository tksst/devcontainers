# syntax=docker/dockerfile:1.2.1
FROM ghcr.io/tksst/devcontainers/devcontainer-base:sha-305beb0-20220503T031506Z

ARG NVM_VER=0.39.1

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VER}/install.sh | bash
RUN echo npm-check-updates >> ~/.nvm/default-packages

ARG NPM_VER=8.8.0

ARG NODE16_VER=16.14.0

# nvm.sh requires bash
RUN bash -c '. $HOME/.nvm/nvm.sh \
&& nvm install ${NODE16_VER} --latest-npm \
&& corepack enable npm yarn pnpm \
&& corepack prepare --activate npm@${NPM_VER} \
'

ARG NODE14_VER=14.19.1

RUN bash -c '. $HOME/.nvm/nvm.sh \
&& nvm install ${NODE14_VER} --latest-npm \
&& corepack enable npm yarn pnpm \
&& corepack prepare --activate npm@${NPM_VER} \
'

ARG NODE18_VER=18.0.0

RUN bash -c '. $HOME/.nvm/nvm.sh \
&& nvm install ${NODE18_VER} --latest-npm \
&& corepack enable npm yarn pnpm \
&& corepack prepare --activate npm@${NPM_VER} \
'