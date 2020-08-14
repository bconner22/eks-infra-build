#!/bin/bash
echo "Checking to see if helm-nodejs-timestamp repo exists"
[ -d "../helm-nodejs-timestamp" ] && echo "Directory  ../helm-nodejs-timestamp exists, not repulling from github." || git clone https://github.com/bconner22/helm-nodejs-timestamp.git ../helm-nodejs-timestamp
pushd ../helm-nodejs-timestamp/
./scripts/deploy.sh
