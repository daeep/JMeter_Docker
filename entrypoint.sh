#!/bin/bash

# Inspired from https://github.com/justb4/docker-jmeter
# Basically runs jmeter, assuming the PATH is set to point to JMeter bin-dir (see Dockerfile)
#
# This script expects the standdard JMeter command parameters.
#

set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "                                      "
echo "                                      "
echo "----  STARTING JMeter Test ---- `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

jmeter $@

echo "----  ENDING JMeter Test ---- `date`"
echo "                                      "
echo "                                      "