#!/bin/bash
set -euo pipefail

IMG=nberserk/armhf-elasticsearch:latest

adb shell docker pull $IMG
adb shell docker run --privileged -d --net=host --name es $IMG
