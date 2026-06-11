#!/bin/bash

if pkexec /usr/bin/true 2>/dev/null; then
  PASSWORD=$(secret-tool lookup title "VaultMasterPassword")
  sleep 0.5
  echo -n "$PASSWORD" | wtype -
  wtype -k Return
else
  exit 1
fi
