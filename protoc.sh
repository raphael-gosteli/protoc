#!/bin/bash
# Warps the conatinerized protoc

export VERSION=2.4.1
export HOST_MOUNT=$PWD
export CONTAINER_MOUNT=$HOST_MOUNT

docker run -it -v $HOST_MOUNT:$CONTAINER_MOUNT raphaelgosteli/protoc:$VERSION "$@"