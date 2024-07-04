#!/usr/bin/env bash

build() {
  local path
  local image_name
  path="$1"
  image_name="$2"
  readonly path
  readonly image_name
  sudo docker build --compress --pull \
    -t "${image_name}" "${path}"
}

push() {
  local image
  image="$1"
  readonly image
  sudo docker push "${image}"
}

trigger_build() {
  curl -X POST https://hub.docker.com/api/build/v1/source/c1d4a09a-e39a-4378-8be0-d0e175c5ab98/trigger/f0e0596d-2c44-4ee9-b44c-36b682e8ef6a/call/ 
}

main() {
  local path
  local timestamp
  local image_name
  local latest
  latest="docker.io/blairy/requests:latest"
  readonly latest
  path="${USERHOME}"/docker/requests
  readonly path
  timestamp=$(/usr/bin/date +%Y%m%d_%H%M)
  readonly timestamp
  echo 'Timestamp: '"${timestamp}"
  image_name='docker.io/blairy/requests:'"${timestamp}"
  readonly image_name
  echo 'image_name: '"${image_name}"
  build "${path}" "${image_name}" || exit 1
  push "${image_name}" || exit 1
  build "${path}" "${latest}" || exit 1
  push "${latest}" || exit 1
  trigger_build || exit 1
}

main "$@"
