#!/usr/bin/env bash

# start my vms
VBoxManage list vms | awk '{print $1}' | xargs -I VM VBoxManage startvm VM --type headless
# xfreerdp /v:192.168.33.11 /u:vagrant /p:vagrant 


# start my ansible docker container
docker run --rm -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa -v ~/.ssh/config:/root/.ssh/config -it willhallonline/ansible:alpine /bin/sh

# stop my vms
VBoxManage list runningvms | awk '{print $1}' | xargs -I VM VBoxManage controlvm VM poweroff
