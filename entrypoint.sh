#!/bin/bash
# @file: entrypoint.sh
# @note: This script is intended to perform setup for specific user, i.e., 1000:1000

MY_UID=1000
MY_GID=1000

# === Setup for GPG socket

# Create /run/user if it doesn't exist
if [ ! -d /run/user ]; then
    sudo mkdir /run/user
fi

# Create the per-user directory and set permissions
if [ ! -d "/run/user/$MY_UID" ]; then
    sudo mkdir /run/user/$MY_UID
    sudo chown $MY_UID:$MY_GID /run/user/$MY_UID
    sudo chmod 0700 /run/user/$MY_UID
    mkdir -m 0700 /run/user/$MY_UID/gnupg
fi

# Start the application or command you wish to run
exec "$@"
