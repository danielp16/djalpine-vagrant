#!/bin/bash

BOXNAME=djalpine36
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../base-box

vagrant up
mkdir -p $DIR/../boxes

if [ -f $DIR/../boxes/$BOXNAME.box ] ; then
    rm $DIR/../boxes/$BOXNAME.box
fi

vagrant package --output $DIR/../boxes/$BOXNAME.box
vagrant box remove $BOXNAME
vagrant box add $BOXNAME $DIR/../boxes/$BOXNAME.box
vagrant destroy --force
