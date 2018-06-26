#!/bin/bash
# https://github.com/wnameless/docker-oracle-xe-11g

clear

echo -e "Starting local Oracle database"
echo -e ""

function stop { 
	echo -e "- stoping oracle-dev..."
	RESULT=$( { docker stop oracle-dev; } 2>&1 )
	echo -e "  result:[$RESULT]"
	echo -e "  done."
}

function remove { 
	echo -e "- removing docker oracle-dev..."
	RESULT=$( { docker rm oracle-dev; } 2>&1 )
	echo -e "  result:[$RESULT]"
	echo -e "  done."
}

function delete { 
	echo -e "- removing existing tablespace..."
	RESULT=$( { rm -rf tablespace/ts_01.dbf; } 2>&1 )
	if [[ -z "${RESULT// }" ]]; then
		RESULT="done."
	fi
	echo -e "  result:[$RESULT]"
	echo -e "  done."
}

function start { 
	echo -e "- starting oracle-dev..."
	RESULT=$( { docker run --name oracle-dev \
		-d -p 49161:1521 \
		-e ORACLE_ALLOW_REMOTE=true \
		-e ORACLE_DISABLE_ASYNCH_IO=true \
		-v $(pwd)/:/scripts \
		wnameless/oracle-xe-11g; 
		} 2>&1 )
	echo -e "  result:[$RESULT]"
	echo -e "  done."
}

function check { 
	echo -e "- check if is running..."
	RESULT=$( { docker ps --format '{{.Names}}' | grep oracle-dev; } 2>&1 )
	if [ "$RESULT" = "oracle-dev" ]; then
		RESULT="running."
	else
		RESULT="not running."
	fi
	echo -e "  result:[$RESULT]"
	echo -e "  done."
}

function ps_container { 
	echo -e "----"
	docker ps --filter "name=oracle-dev"
	echo -e "----"
}

function copy_scripts { 
	# cp ./../../dbscripts/CreateObjectsMaio/ChangeDdsDatabaseMaio.sql sql/
	# cp ./../../dbscripts/CreateObjectsJunho/ChangeDdsDatabaseJunho.sql sql/
	echo -e ""
}

copy_scripts
stop
remove
delete
start
check
echo -e ""
ps_container

docker exec -it oracle-dev /scripts/1.init.sh


