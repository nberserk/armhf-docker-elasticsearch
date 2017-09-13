#!/bin/bash
set -euo pipefail

IMG=nberserk/armhf-elasticsearch:latest

#docker tag ies $IMG
docker push $IMG
