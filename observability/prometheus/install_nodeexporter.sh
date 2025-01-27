#!/bin/bash

EXPORTER_VERSION="v1.8.2"
EXPORTER_FILE="node_exporter-1.8.2.linux-amd64"

wget https://github.com/prometheus/node_exporter/releases/download/"${EXPORTER_VERSION}"/"${EXPORTER_FILE}".tar.gz
tar xvf "${EXPORTER_FILE}".tar.gz
cd "${EXPORTER_FILE}"
sudo cp node_exporter /usr/local/bin

sudo useradd --no-create-home --shell /bin/false node_exporter
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
cd -
sudo cp node_exporter.service /etc/systemd/system/node_exporter.service

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
sudo systemctl status node_exporter