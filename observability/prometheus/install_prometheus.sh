#!/bin/bash
PROMETHEUS_VERSION="v2.53.3"
PROMETHEUS_FILE="prometheus-2.53.3.linux-amd64"

sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
wget https://github.com/prometheus/prometheus/releases/download/"${PROMETHEUS_VERSION}"/"${PROMETHEUS_FILE}".tar.gz
tar xvf "${PROMETHEUS_FILE}".tar.gz
cd "${PROMETHEUS_FILE}"

sudo cp prometheus /usr/local/bin/
sudo cp promtool /usr/local/bin
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo cp prometheus.yml /etc/prometheus/prometheus.yml
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
cd -
sudo cp prometheus.service /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload

sudo systemctl start prometheus
sudo systemctl enable prometheus
sudo systemctl status prometheus