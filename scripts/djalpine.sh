#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $# -eq 0 ]; then
    echo "djalpine [PROJECT_NAME] "
    echo "whats your project name:"
    read proj
    if [ -z "$proj"]; then
      PROJECT_NAME=djalpine
    else
      PROJECT_NAME=$proj
    fi
else
    PROJECT_NAME=$1
fi

sh $DIR/01-generate-box.sh
sh $DIR/02-generate-vagrant.sh $PROJECT_NAME
