# djalpine-vagrant
Vagrant Files for django projects on alpine linux box

IMPORTANT - The project currently in development and not ready for use.

## What is this project?

This is a set of bash scripts and Vagrantfile's that needed to easily create working dev environment.
Main focus is for Django projects provisioned on alpine machines.

## Stack versions in use:

Alpine Linux 3.6 - generic/alpine36 (vagrant box) - chosen Provider is VirtualBox
Postgres DB 9.6
Python 3.6

* python packages like django can be installed according to requirements file in your project. you can also add more later inside provisioned vm

## ## How do I use it:

prerequisite - install vagrant and preferably some IDE/text editor for development
clone the repo

run the `djalpine.sh` script for full provision or each step separately
`01-generate-box.sh` will create new box from generic/alpine 3.6
`02-generate-vagrant` generates final Vagranfile to be used in your project,
note give it your project name as cli argument.

as an output you will get new `Vagranfile` and a new vm box  

copy the generated `Vagrantfile` to your project root folder
then:
`Vagrant up`
and you good to go

Happy Django coding :)
