#!/bin/bash

/usr/bin/docker run -t --rm=true --name jenkins_container jenkins-alpine:latest ash

# /usr/bin/docker run -t --rm=true --name jenkins_container --mount type=bind,source=/srv/data/jenkins,target=/var/jenkins_home jenkins-alpine:latest ash
