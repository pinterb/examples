#!/bin/bash

# vim: filetype=sh:tabstop=2:shiftwidth=2:expandtab

readonly PROGNAME=$(basename $0)
readonly PROGDIR="$( cd "$(dirname "$0")" ; pwd -P )"
readonly ARGS="$@"
readonly TODAY=$(date +%Y%m%d%H%M%S)

# pull in utils
source "${PROGDIR}/utils.sh"

if ! command_exists kubectl; then
  echo ""
  error "kubectl wasn't found."
  echo ""
  exit 1
fi


echo ""
hdr "Step 1. starting alpaca-prod deployment..."
echo ""

kubectl run alpaca-prod \
  --image=gcr.io/kuar-demo/kuard-amd64:1 \
  --replicas=3 \
  --port=8080 \
  --labels="ver=1,app=alpaca,env=prod"

echo ""
hdr "Step 2. exposing alpaca-prod deployment as a service..."
echo ""

kubectl expose deployment alpaca-prod


echo ""
hdr "Step 3. starting bandicoot-prod deployment..."
echo ""

kubectl run bandicoot-prod \
  --image=gcr.io/kuar-demo/kuard-amd64:1 \
  --replicas=2 \
  --port=8080 \
  --labels="ver=2,app=bandicoot,env=prod"

echo ""
hdr "Step 4. exposing bandicoot-prod deployment as a service..."
echo ""

kubectl expose deployment bandicoot-prod

