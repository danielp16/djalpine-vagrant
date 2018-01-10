#!/bin/bash
apk update
apk add rsync
apk add libpq-dev
apk add postgresql-dev
apk add postgresql
apk add postgresql-contrib
apk add python3
apk add python3-dev
apk add htop
apk add mc
apk add nano
apk add rxvt-unicode
apk add git
apk add gcc
apk add musl-dev
rm -f /var/cache/apk/*
pip3 --no-cache-dir install virtualenv
pip3 --no-cache-dir install virtualenvwrapper
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
history -c
