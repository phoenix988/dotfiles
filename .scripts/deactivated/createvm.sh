#!/bin/bash


template=$(cat $HOME/Documents/templatevm.xml)

uuid=$(uuidgen)

disk=$(echo "$1")



echo $template | sed "s/template/$disk/" | sed "s/templateuuid/$uuid/" | sed "s/templatedisk/$disk/" > $HOME/Documents/newvm.xml

sudo virsh vol-create-as --name $1.qcow2 --pool vhd --capacity 30g

sudo chown nobody:kvm /media/vm/$1.qcow2

sudo virsh create $HOME/Documents/newvm.xml
