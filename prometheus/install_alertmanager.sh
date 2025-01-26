#!/bin/bash

sudo useradd --no-create-home --shell /bin/false alertmanager
sudo mkdir /etc/alertmanager


wget https://github.com/prometheus/alertmanager/releases/download/v0.28.0/alertmanager-0.28.0.linux-amd64.tar.gz

tar xzf alertmanager-0.28.0.linux-amd64.tar.gz
cd alertmanager-0.28.0.linux-amd64
sudo mv alertmanager.yml /etc/alertmanager
sudo chown -R alertmanager:alertmanager /etc/alertmanager
sudo mkdir /var/lib/alertmanager
sudo chown -R alertmanager:alertmanager /var/lib/alertmanager
sudo cp alertmanager /usr/local/bin
sudo cp amtool /usr/local/bin
sudo chown alertmanager:alertmanager /usr/local/bin/alertmanager
sudo chown alertmanager:alertmanager /usr/local/bin/amtool

# the service will listen on port 9093
cd -
sudo cp alertmanager.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start alertmanager
sudo systemctl enable alertmanager
sudo systemctl status alertmanager