#!/bin/bash

if tl gen --check luacmdargs.tl; then
  cp -v luacmdargs.lua /usr/local/lib/lua/5.4/.
  cp -v luacmdargs.tl  /usr/local/lib/lua/5.4/.
else
  echo "build failed"
fi
