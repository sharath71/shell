#!/bin/bash

if command -v docker &> /dev/null; then
   echo "Docker is Installed"
   dv=$(docker --version)
   echo "$dv "
else
   echo " Docker is Not Installed "
fi
