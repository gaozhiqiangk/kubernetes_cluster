#!/bin/bash

set -e

HOST=`hostname -s`
DOMAIN=`hostname -d`
BROKER_ID=${HOST##*-}


CONF_DIR=/opt/kafka/config

function create_server_properties() {
	mv $CONF_DIR/server.properties{,.bak}
	broker.id=$BROKER_ID
	#listeners=PLAINTEST://:9002
	#advertised.listeners=PLAINTEXT://your.host.name:9092
	#listener.security.protocol.map=PLAINTEXT:PLAINTEXT,SSL:SSL,SASL_PLAINTEXT:SASL_PLAINTEXT,SASL_SSL:SASL_SSL
	num.network.threads=3
	num.io.threads=3
	socket.send.buffer.bytes=102400
	socket.receive.buffer.bytes=102400
	socket.request.max.bytes=104857600
	log.dirs=/tmp/kafka-logs
	num.partitions=1
	num.recovery.threads.per.data.dir=1
	offsets.topic.replication.factor=1
	transaction.state.log.min.isr=1
	#log.flush.interval.messages=10000
	#log.flush.interval.ms=1000
	log.retention.hours=168
	#log.retention.bytes=1073741824
	log.segment.bytes=1073741824
	log.retention.check.interval.ms=300000
	zookeeper.connect=localhost:2181
	zookeeper.connection.timeout.ms=6000
	group.interval.rebalance.delay.ms=0

}

exec "$@"
