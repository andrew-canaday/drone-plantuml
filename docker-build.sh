#!/usr/bin/env bash

DOCKER_PU_USER="${DOCKER_PU_USER:-"andrewcanaday"}"
DOCKER_PU_IMAGE="${DOCKER_PU_IMAGE:-"drone-plantuml"}"
DOCKER_PU_TAG="${DOCKER_PU_TAG:-"latest"}"

docker build ./ \
    -t "${DOCKER_PU_USER}/${DOCKER_PU_IMAGE}:${DOCKER_PU_TAG}"

# EOF

