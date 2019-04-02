#!/bin/bash
set -u

readonly ACCOUNT="${ONEPASSWORD_ACCOUNT-YourAccount}"
readonly AUTH_FILE="$1"
readonly SERVICE_NAME="$2"

pass=$(eval OP_SESSION_$ACCOUNT=$(cat $AUTH_FILE) op get totp $SERVICE_NAME)
if [[ -z "${pass}" ]]; then
  tmux split-window "op signin $ACCOUNT --output=raw > $AUTH_FILE"
  while pgrep -f 'op signin ' >/dev/null; do
    sleep 1
  done
  if [[ ! -s $AUTH_FILE ]]; then
    exit
  fi
  pass=$(eval OP_SESSION_$ACCOUNT=$(cat $AUTH_FILE) op get totp $SERVICE_NAME)
fi

if [[ $# -ge 3 ]]; then
  readonly PANE_ID=$3
  tmux send-keys -t ${PANE_ID} "${pass}" C-m
else
  echo "${pass}"
fi
