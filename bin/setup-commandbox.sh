#!/bin/bash

echo "Begin setup commandbox"

# # # Installs the latest CommandBox Binary
mkdir -p /tmp
curl -k  -o /tmp/box.zip -location "https://s3.amazonaws.com/downloads.ortussolutions.com/ortussolutions/commandbox/5.6.1/commandbox-bin-5.6.1.zip"
unzip /tmp/box.zip -d ${BIN_DIR} && chmod 755 ${BIN_DIR}/box

echo "commandbox_home=${COMMANDBOX_HOME}" > ${BIN_DIR}/commandbox.properties