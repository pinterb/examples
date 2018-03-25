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
hdr "kubectl get pods -l app=alpaca -o jsonpath='{.items[0].metadata.name}'"
echo ""


