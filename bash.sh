#!/bin/bash
mkdir -p $(dirname $0)/work
source $(dirname $0)/versions
MOUNT=$(dirname $0)/work:/work
VERSION=${IMAGE_VERSION}-${LOGSTASH_VERSION}
docker run -it --rm -v $MOUNT v42net/logstash-plugin-dev:${VERSION} bash
