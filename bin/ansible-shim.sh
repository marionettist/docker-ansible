#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
ANSIBLE_VERSION=$(grep "ENV ANSIBLE_VERSION" "$SCRIPT_DIR/../Dockerfile" | cut -d ' ' -f 3)

docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/ansible/playbooks \
  -v /var/log/ansible/ansible.log \
  marionettist/ansible:$ANSIBLE_VERSION "$@"
  # marionettist/ansible:$version ansible "$@"
  # marionettist/ansible:$version ansible-playbook "$@"
