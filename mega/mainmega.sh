#!/bin/sh


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HOME=$DIR/mathias
echo $HOME

megasync 2> /dev/null &
