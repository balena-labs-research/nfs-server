#!/usr/bin/env sh

# Load required modules
modprobe nfs
modprobe nfsd

## Run NFS Server
mkdir /run/openrc
touch /run/openrc/softlevel
openrc

exec "$@"
