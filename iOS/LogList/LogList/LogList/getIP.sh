#!/bin/bash
export vals="$(ifconfig | grep inet | grep broadcast)"
IFS=' ' read -r -a arrs <<< "$vals"
export val="${arrs[1]}"
export Server="http://${val}:5000"

export File="/LogListHeader.h"
export Path="$(find -L . | grep ${File})"
echo "#define LOG_SERVER @\"${Server}\"" > "${Path}"
