#!/bin/bash
# https://github.com/wnameless/docker-oracle-xe-11g

clear

docker stop oracle-dev
docker rm oracle-dev
rm -rf tablespace/ts_01.dbf
docker run --name oracle-dev \
	-d -p 49161:1521 \
	-e ORACLE_ALLOW_REMOTE=true \
	-e ORACLE_DISABLE_ASYNCH_IO=true \
	-v $(pwd)/:/scripts \
	wnameless/oracle-xe-11g