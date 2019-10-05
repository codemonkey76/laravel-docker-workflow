#!/bin/sh
docker run -it --privileged --pid=host redis:latest nsenter -t 1 -m -u -n -i sh -c 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'
docker run -it --privileged --pid=host redis:latest nsenter -t 1 -m -u -n -i sh -c 'echo never > /sys/kernel/mm/transparent_hugepage/defrag'

