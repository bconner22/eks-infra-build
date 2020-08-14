#!/bin/bash
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${__dir}/prereqs.sh
source ${__dir}/eksinstall.sh
source ${__dir}/helmdeploy.sh