#!/bin/sh

BINPATH=`xcode-select -p`"usr/bin/"
echo "Print man pages for tools in '$BINPATH'"
TOOLS=`ls $BINPATH`

for tool in ${TOOLS}; do
  echo "====== $tool:" >> tools.txt
  man -P cat $tool 2>&1 | col -b | grep -A 2 NAME >> tools.txt
  echo "\n" >> tools.txt
done
