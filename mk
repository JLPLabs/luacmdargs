#!/bin/bash

# a nice local location to keep utilities and libraries
INSTALL="$HOME/.local/share/lua/5.4/"

#
#  NOTE  Make sure your LUA_PATH includes the selected directory
#

if tl gen --check luacmdargs.tl; then
  cp -v luacmdargs.lua "$INSTALL"
  cp -v luacmdargs.tl  "$INSTALL"
else
  echo "build failed"
fi
