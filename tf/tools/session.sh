#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker build $DIR -t tf12:latest

docker run -ti \
--rm \
-v /run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock \
-e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock" \
-v $(pwd):/apps \
tf12:latest bash


# https://stackoverflow.com/questions/41485217/mount-current-directory-as-a-volume-in-docker-on-windows-10