#!/bin/bash

SERVER_PROPERTIES=/opt/kafka/config/server.properties

# ARG_NAME如BROKER_ID
# ARG_VALUE如2
convert_server_property(){
	local ARG_NAME=$1
	local ARG_VALUE=$2
	local PROPERTY=`echo $ARG_NAME | tr _ . | tr A-Z a-z`
	sed -i "s/${PROPERTY}=.*/${PROPERTY}=${ARG_VALUE}/g" $SERVER_PROPERTIES

}

echo
sed -i "s/broker.id=0/broker.id=${BROKER_ID}/g" /opt/kafka/config/server.properties

#listeners=PLAINTEXT://:9092
#advertised.listeners=PLAINTEXT://your.host.name:9092
#listener.security.protocol.map=PLAINTEXT:PLAINTEXT,SSL:SSL,SASL_PLAINTEXT:SASL_PLAINTEXT,SASL_SSL:SASL_SSL
num.network.threads=3
num.io.threads=8
socket.send.buffer.bytes=102400
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
log.dirs=/tmp/kafka-logs
num.partitions=1
num.recovery.threads.per.data.dir=1
offsets.topic.replication.factor=1
transaction.state.log.replication.factor=1
transaction.state.log.min.isr=1
#log.flush.interval.messages=10000

# The maximum amount of time a message can sit in a log before we force a flush
#log.flush.interval.ms=1000
log.retention.hours=168

# A size-based retention policy for logs. Segments are pruned from the log unless the remaining
# segments drop below log.retention.bytes. Functions independently of log.retention.hours.
#log.retention.bytes=1073741824

# The maximum size of a log segment file. When this size is reached a new log segment will be created.
log.segment.bytes=1073741824

# The interval at which log segments are checked to see if they can be deleted according
# to the retention policies
log.retention.check.interval.ms=300000

zookeeper.connect=localhost:2181

# Timeout in ms for connecting to zookeeper
zookeeper.connection.timeout.ms=6000
group.initial.rebalance.delay.ms=0

exec "$@"
