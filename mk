#!/bin/bash

# a nice local location to keep utilities and libraries
INSTALL=false
INSTALL_DIR="$HOME/.local/share/lua/5.4/"

#
#  NOTE  Make sure your LUA_PATH includes the selected directory
#

if tl gen --check luacmdargs.tl; then
  if $INSTALL; then
    cp -v luacmdargs.lua "$INSTALL_DIR"
    cp -v luacmdargs.tl  "$INSTALL_DIR"
  fi
else
  echo "build failed"
fi
