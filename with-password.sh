#!/usr/bin/env bash
set -eu

readonly ACCOUNT="${ONEPASSWORD_ACCOUNT-YourAccount}"
readonly AUTH_FILE="$1"
readonly SERVICE_NAME="$2"
readonly PANE_ID="$3"

op signin ${ACCOUNT} --output=raw > ${AUTH_FILE}
pass=$(eval OP_SESSION_${ACCOUNT}=$(cat ${AUTH_FILE}) op get totp ${SERVICE_NAME})

if [[ -n ${pass} ]]; then
  if [[ -n "${PANE_ID}" ]]; then
    tmux send-keys -t ${PANE_ID} "${pass}" C-m
  else
    echo "${pass}"
  fi
fi
