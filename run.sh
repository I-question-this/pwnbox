#!/bin/sh

SCRIPT_DIR="$(realpath $(dirname "$0"))"

version=$(cat VERSION.txt)
build_tag=local-build$version

sudo docker run -d --name pwnbox --hostname pwnbox --network host -v $SCRIPT_DIR/.pwnbox/home:/root -v $SCRIPT_DIR/.pwnbox/external:/mnt/external pwnbox:$build_tag
