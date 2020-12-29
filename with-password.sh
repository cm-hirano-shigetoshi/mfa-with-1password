#!/usr/bin/env bash
set -eu

readonly ACCOUNT="$1"
readonly AUTH_FILE="$2"
readonly SERVICE_NAME="$3"
readonly PANE_ID="$4"

op signin ${ACCOUNT} --output=raw > ${AUTH_FILE}
pass=$(eval OP_SESSION_${ACCOUNT}=$(cat ${AUTH_FILE}) op get totp ${SERVICE_NAME})

if [[ -n "${pass}" ]]; then
  if [[ -n "${PANE_ID}" ]]; then
    tmux send-keys -t ${PANE_ID} "${pass}" C-m
  else
    echo "${pass}"
  fi
fi
