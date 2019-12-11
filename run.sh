#!/bin/sh

docker run --rm -d --name "$(basename `pwd`)-test-`date "+%F_%H-%M"`" -h "$(basename `pwd`)-test-`date "+%F_%H-%M"`" -v `pwd`:/opt -t "registry.mysmartflat.tech/pythonbox"

