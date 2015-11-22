#!/bin/bash

set -e -x -u

docker-machine start default || true 

eval "$(docker-machine env default)"

ip="$(docker-machine ip default)"

echo "IP=$ip"

if [ "${1:-}" == "" ] ; then
  args=(/bin/sh -c 'jekyll serve --force_polling')
else
  args=$@
fi

IMAGE=jekyll/jekyll:stable


docker pull $IMAGE
docker run --rm --label=jekyll --volume=$(pwd):/srv/jekyll \
  -it -p 4000:4000 $IMAGE "${args[@]}"

