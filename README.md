# djalpine-vagrant
Vagrant Files for django projects on alpine box

IMPORTANT - The project currently in development and not ready for use.

## What is this project?

This is a set of Vagrantfile's that needed to easily create working dev environment.
Main focus is for Django projects provisioned on alpine machines.

## Stack versions in use:

Alpine Linux 3.6 - generic/alpine36 (vagrant box) - chosen Provider is VirtualBox
Postgres DB 9.6
Python 3.6
Django 2.0.1
Django Rest Framework

## ## How do I use it:

prerequisite - install vagrant and preferably some IDE/text editor for development
clone the repo
in command line:
1. build the base box
2. add it to your vagrant boxes
3. copy the main Vagrantfile in your project
4. from your project vagrant up the name of the new box

Happy Django coding :)
