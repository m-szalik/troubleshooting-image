#!/bin/bash

HASH=`git reflog -n 1|cut -d' ' -f1`
docker build -t szalik/troubleshooting-image . && docker push szalik/troubleshooting-image
docker tag szalik/troubleshooting-image "szalik/troubleshooting-image:$HASH"
docker push "szalik/troubleshooting-image:$HASH"

