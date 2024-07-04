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
}

main "$@"