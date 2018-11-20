# Ansible Playbook Docker Image

Based on [walokra/ansible-playbook](https://github.com/walokra/docker-ansible-playbook)

Docker Image of Ansible for executing ansible-playbook command and other ansible commands against an externally mounted set of Ansible playbooks.

Based on [philm/ansible_playbook](https://github.com/philm/ansible_playbook)

## Build

```
./docker-build.sh
```

### Test

```
$ docker run --name ansible --rm marionettist/ansible ansible-playbook --version

ansible-playbook 2.3.0.0
  config file =
  configured module search path = [u'/opt/ansible/library']
  python version = 2.7.13 (default, Apr 20 2017, 12:13:37) [GCC 6.3.0]
```

## Running Ansible Playbook

```
docker run --rm -it -v PATH_TO_LOCAL_PLAYBOOKS_DIR:/ansible/playbooks marionettist/ansible ansible-playbook PLAYBOOK_FILE
```

For example, assuming your project's structure follows [best practices](http://docs.ansible.com/ansible/playbooks_best_practices.html#directory-layout), the command to run ansible-playbook from the top-level directory would look like:

```
docker run --rm -it -v $(pwd):/ansible/playbooks marionettist/ansible ansible-playbook site.yml
```

Ansible playbook variables can simply be added after the playbook name.

### Ansible Helper wrapper

There are helper scripts to make it easier to call the various ansible commands.

Put the `bin` folder in your `PATH` and you will be able to run `ansible-playbook.sh`, etc...

## SSH Keys

If Ansible is interacting with external machines, you'll need to mount an SSH key pair for the duration of the play:

```
docker run --rm -it \
    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
    -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v $(pwd):/ansible/playbooks \
    marionettist/ansible ansible-playbook site.yml
```

## Ansible Vault

If you've encrypted any data using [Ansible Vault](http://docs.ansible.com/ansible/playbooks_vault.html), you can decrypt during a play by either passing **--ask-vault-pass** after the playbook name, or pointing to a password file. For the latter, you can mount an external file:

```
docker run --rm -it -v $(pwd):/ansible/playbooks \
    -v ~/.vault_pass.txt:/root/.vault_pass.txt \
    marionettist/ansible ansible-playbook \
    site.yml --vault-password-file /root/.vault_pass.txt
```                    

Note: the Ansible Vault executable is embedded in this image. To use it, specify a different entrypoint:

```
docker run --rm -it -v $(pwd):/ansible/playbooks \
  marionettist/ansible ansible-vault encrypt FILENAME
```
