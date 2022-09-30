#!/bin/bash

# install all dependencies

cd /app

# Check if we have already installed ContentBox

FILE=/app/.cb-installed
if [ -f "$FILE" ]; then
    echo "$FILE exists. Skipping ContentBox install."
else 
    echo "$FILE does not exist."

    box install contentbox-installer --force
    touch /app/.cb-installed
fi

box install
box install cors
rm .env

cp /tmp/config/Coldbox.cfc /app/config/
cp /tmp/config/Router.cfc /app/config/

box server start \
    trayEnable=false \
    host=0.0.0.0 \
    openbrowser=false \
    port=8080 \
    sslPort=8443 \
    saveSettings=false  \
    dryRun=false \
    console=false \
    startScript=bash \
    verbose=true

# TODO: why is container exiting?
# this keeps it alive so we can exec in
ping localhost
