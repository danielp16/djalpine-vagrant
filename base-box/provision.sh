#!/bin/bash
apk update
apk add gcc
apk add musl-dev
apk add rsync

apk add gosu@testing

$PG_MAJOR=9.6
$PG_VERSION=9.6.6
$PATH=/usr/lib/postgresql/$PG_MAJOR/bin:$PATH
$PGDATA=/var/lib/postgresql/data

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

rm -f /var/cache/apk/*
pip3 --no-cache-dir install virtualenv
pip3 --no-cache-dir install virtualenvwrapper

echo "======================================================"
export PG_MAJOR=9.6
export PG_VERSION=9.6.6
export PATH=$PATH:/usr/lib/postgresql/$PG_MAJOR/bin
export PGDATA=/var/lib/postgresql/data
echo $PGDATA
sudo mkdir -p $PGDATA

if ! [ -z "$(sudo ls -A "$PGDATA")" ]; then
    sudo rm -rf $PGDATA
    sudo mkdir -p $PGDATA
fi

sudo chown -R postgres "$PGDATA"

if [ -z "$(sudo ls -A "$PGDATA")" ]; then
    sudo sed -i "s,#listen_addresses = 'localhost',listen_addresses = '*',g" /usr/share/postgresql/postgresql.conf.sample
    sudo sed -i "s,127.0.0.1/32,0.0.0.0/0,g" /usr/share/postgresql/pg_hba.conf.sample

    sudo gosu postgres initdb -D $PGDATA

    sudo sed -i "s,#listen_addresses = 'localhost',listen_addresses = '*',g" $PGDATA/postgresql.conf
    sudo sed -i "s,127.0.0.1/32,0.0.0.0/0,g" $PGDATA/pg_hba.conf

    : ${POSTGRES_USER:="postgres"}
    : ${POSTGRES_DB:=$POSTGRES_USER}

    if [ "$POSTGRES_PASSWORD" ]; then
      pass="PASSWORD '$POSTGRES_PASSWORD'"
      authMethod=md5
    else
      echo "==============================="
      echo "!!! NO PASSWORD SET !!! (Use \$POSTGRES_PASSWORD env var)"
      echo "==============================="
      pass=
      authMethod=trust
    fi
    echo


    if [ "$POSTGRES_DB" != 'postgres' ]; then
      createSql="CREATE DATABASE $POSTGRES_DB;"
      echo $createSql | sudo gosu postgres postgres --single -jE -D $PGDATA
      echo
    fi

    if [ "$POSTGRES_USER" != 'postgres' ]; then
      op=CREATE
    else
      op=ALTER
    fi

    userSql="$op USER $POSTGRES_USER WITH SUPERUSER $pass;"
    echo $userSql | sudo gosu postgres postgres --single -jE -D $PGDATA
    echo


    sudo mkdir -p /var/run/postgresql
    sudo chown -R postgres:postgres /var/run/postgresql

    sudo gosu postgres pg_ctl -D "$PGDATA" \
        -o "-c listen_addresses=''" \
        -w start

    echo

    sudo gosu postgres pg_ctl -D "$PGDATA" -m fast -w stop

fi

sudo rc-update add postgresql default
sudo rc-service postgresql start
echo "======================================================"

sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
sudo history -c
