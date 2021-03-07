#!/bin/bash
USER="test-monitoring@cloudbest.local"
PASS='2x9IzrOfTUjyNwL_'
HOST="192.168.4.39"

docker run -it --rm  -p 9272:9272 -e VSPHERE_USER=${USER} -e VSPHERE_PASSWORD=${PASS} -e VSPHERE_HOST=${HOST} -e VSPHERE_IGNORE_SSL=True -e VSPHERE_SPECS_SIZE=2000 --name vmware_exporter pryorda/vmware_exporter
