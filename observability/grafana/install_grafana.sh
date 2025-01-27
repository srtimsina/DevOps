#!/bin/bash
sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_11.4.0_amd64.deb
sudo dpkg -i grafana-enterprise_11.4.0_amd64.deb