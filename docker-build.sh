#!/usr/bin/env sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
ANSIBLE_VERSION=$(grep "ENV ANSIBLE_VERSION" "$SCRIPT_DIR/Dockerfile" | cut -d ' ' -f 3)
docker build -t marionettist/ansible:$ANSIBLE_VERSION .
