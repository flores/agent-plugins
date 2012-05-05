#!/bin/bash
#
# License: MIT
# Copyright: Carlo Flores <github@petalphile.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

if [ $# -lt 1 ]; then
  echo "Usage: $0 <process> <expected number of processes>"
  echo "ex: $0 apache 5"
  echo -e "<expected number of processes> is optional and defaults to 1\n"
  exit
fi

PROCESS_NAME=$1

if [ -z $2 ]; then
  EXPECTED_PROCESSES=1
else
  EXPECTED_PROCESSES=$2
fi

NUM_PROCESSES=`ps ax | grep "$PROCESS_NAME" | grep -v grep | wc -l`

if [ -z $NUM_PROCESSES ]; then
  NUM_PROCESSES=0
fi

if [ "$NUM_PROCESSES" -eq "$EXPECTED_PROCESSES" ]; then
  echo "status ok ok"
elif [ "$NUM_PROCESSES" -lt "$EXPECTED_PROCESSES" ]; then
  echo "status err $PROCESS_NAME has less than $EXPECTED_PROCESSES processes running"
else
  echo "status warn $PROCESS_NAME has $NUM_PROCESSES processes running.  expected $EXPECTED_PROCESSES processes running"
fi
