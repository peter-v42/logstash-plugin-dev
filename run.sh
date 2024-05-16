#!/bin/bash
MOUNT=$(dirname $0)/work:/work
docker run -it --rm -v $MOUNT v42net/logstash-plugin-dev-a:test bash
