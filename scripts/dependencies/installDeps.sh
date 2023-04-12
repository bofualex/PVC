#!/bin/bash

python_cmd=${1:-python3}

# usage:
#       sh installDeps.sh (defaults to the usage of 'python3' keyword)
#       if your os uses the 'python'(or any other keyword) keyword for python3,
#       the cmd should be 'sh installDeps.sh python(or any other keyword)'
# 
#       to find out if the python3 keyword exists, run 'which python3'
#       to find out the version of a python, run 'python(or python3 or whatever) --version'

# pip
# $python_cmd -m pip install -U 