#!/bin/sh

apply_schema() { 
	echo "- applying schema"
	echo "  ---------------------------"
	exit | sqlplus system/oracle < sql/schema_scripts.pdc 
	echo "  ---------------------------"
	echo "  done."
}

wait_ready() { 
	echo ""
	echo -n "- waiting for database to be ready"
	
	RESULT=
	while [ -z "$RESULT" ]
	do
		echo -n "."
		RESULT=`sqlplus system/oracle <<EOF
		select concat('xpto','1234') as xpto from dual;
		exit;
		EOF`
		RESULT=`echo $RESULT | grep xpto1234`
		sleep 1
	done
	
	echo ""
	echo "  database is ready to use."
	echo "  done."
	echo ""
}

export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

export ORACLE_ALLOW_REMOTE=true
export ORACLE_DISABLE_ASYNCH_IO=true
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE

cd scripts/

wait_ready

apply_schema

wait_ready

