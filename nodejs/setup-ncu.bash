#!/usr/bin/bash

set -e
set -u
set -o pipefail
set -o posix

. "$HOME/.nvm/nvm.sh"
nvm use "$NODE_VERSION"

i=5

# Try to install ncu 5 times
for (( ; i > 0; i-- )); do
  npm install -g "npm-check-updates${NCU_VERSION-}" && break
done
