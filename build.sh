#!/bin/bash
source $(dirname $0)/versions
IMAGE_NAME=v42net/logstash-plugin-dev
VERSION_TAG=${IMAGE_VERSION}-${LOGSTASH_VERSION}
docker build --progress=plain ${BUILD_ARGS} --no-cache  \
    --build-arg=IMAGE_VERSION=${IMAGE_VERSION}          \
    --build-arg=LOGSTASH_VERSION=${LOGSTASH_VERSION}    \
    -t ${IMAGE_NAME}:${VERSION_TAG}        .
docker push ${IMAGE_NAME}:${VERSION_TAG}
