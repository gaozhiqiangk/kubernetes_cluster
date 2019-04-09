#!/usr/bin/env bash

ZK_USER=${ZK_USER:-"zookeeper"}
ZK_LOG_LEVEL=${ZK_LOG_LEVEL:-"INFO"}
ZK_DATA_DIR=${ZK_DATA_DIR:-"/var/lib/zookeeper/data"}
ZK_DATA_LOG_DIR=${ZK_DATA_LOG_DIR:-"/var/lib/zookeeper/log"}
ZK_LOG_DIR=${ZK_LOG_DIR:-"var/log/zookeeper"}
ZK_CONF_DIR=${ZK_CONF_DIR:-"/opt/zookeeper/conf"}
ZK_CLIENT_PORT=${ZK_CLIENT_PORT:-2181}
ZK_SERVER_PORT=${ZK_SERVER_PORT:-2888}
ZK_ELECTION_PORT=${ZK_ELECTION_PORT:-3888}
ZK_TICK_TIME=${ZK_TICK_TIME:-2000}
ZK_INIT_LIMIT=${ZK_INIT_LIMIT:-10}
ZK_SYNC_LIMIT=${ZK_SYNC_LIMIT:-5}
ZK_HEAP_SIZE=${ZK_HEAP_SIZE:-2G}
ZK_MAX_CLIENT_CNXNS=${ZK_MAX_CLIENT_CNXNS:-60}
ZK_MIN_SESSION_TIMEOUT=${ZK_MIN_SESSION_TIMEOUT:-$((ZK_TICK_TIME*2))}
ZK_SNAP_RETAIN_COUNT=${ZK_SNAP_RETAIN_COUNT:-3}
ZK_PURGE_INTERVAL=${ZK_PURGE_INTERVAL:-0}
ID_FILE="$ZK_DATA_DIR/myid"
ZK_CONFIG_FILE="$ZK_CONF_DIR/zoo.cfg"
LOGGER_PROPS_FILE="$ZK_CONF_DIR/log4j.properties"
JAVA_ENV_FILE="$ZK_CONF_DIR/java.env"
HOST=`hostname -s`
DOMAIN=`hostname -d`

function print_servers(){
	for ((I=0; I<$ZK_REPLICAS; I++)); do
		echo "server.${I}=${HOST}.${DOMAIN}:${ZK_SERVER_PORT}:${ZK_ELECTION_PORT}"
	done
}

function validate_env(){
	echo "Validating environment"

	if [ -z $ZK_REPLICAS ]; then
		echo "ZK_REPLICAS is mandatory environment variable"
		exit 1
	fi

	if [[ $HOST =~ (.*)-([0-9]+)$ ]]; then
		MY_ID=$(echo ${HOST} | cut -d- -f2)
	else
		echo "Failed to extract ordinal from hostname ${HOST}"
	fi

	echo "ZK_REPLICAS=$ZK_REPLICAS"
	echo "MY_ID=$MY_ID"
	echo "ZK_LOG_LEVEL=$ZK_LOG_LEVEL"
	echo "ZK_DATA_DIR=$ZK_DATA_DIR"
	echo "ZK_DATA_LOG_DIR=$ZK_DATA_LOG_DIR"
	echo "ZK_LOG_DIR=$ZK_LOG_DIR"
	echo "ZK_CLIENT_PORT=$ZK_CLIENT_PORT"
	echo "ZK_SERVER_PORT=$ZK_SERVER_PORT"
	echo "ZK_ELECTION_PORT=$ZK_ELECTION_PORT"
}
