#!/bin/bash

docker-machine start default

eval "$(docker-machine env default)"

ip="$(docker-machine ip default)"

echo "IP=$ip"

if [ "${1:-}" == "" ] ; then
  args=(jekyll serve --force_polling)
else
  args=$@
fi


docker run --rm --label=jekyll --volume=$(pwd):/srv/jekyll \
  -it -p 4000:4000 jekyll/jekyll:pages ${args[*]}

