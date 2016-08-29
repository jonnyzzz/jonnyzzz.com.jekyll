#!/bin/bash

set -e -x -u

if [ "${1:-}" == "" ] ; then
  args=(/bin/sh -c 'bundle update; while true; do bundle exec jekyll serve --trace --force_polling; read -p "Restart?"; done')
else
  args=$@
fi

IMAGE=jekyll/jekyll:stable


docker pull $IMAGE
docker run --rm --label=jekyll --volume=$(pwd):/srv/jekyll \
  -it -p 4000:4000 $IMAGE "${args[@]}"

