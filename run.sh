#!/bin/bash

RUNPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RUNPATH/SuperBuild/install/lib
export PYTHONPATH=$RUNPATH/SuperBuild/install/lib/python3.9/site-packages
python3 $RUNPATH/run.py "$@"
