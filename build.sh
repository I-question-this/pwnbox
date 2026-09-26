#!/bin/sh

version=$(cat VERSION.txt)
build_tag=local-build$version
sudo docker build . -t pwnbox:$build_tag
