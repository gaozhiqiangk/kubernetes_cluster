#!/bin/bash

# broker.id=0
BROKER_ID=echo $POD_NAME | cut -d- -f2
sed -i "s/broker\.id=.*/broker\.id=${BROKER_ID}/g" /opt/kafka/config/server.properties

# log.dirs=/tmp/kafka-logs
sed -i "s/log\.dirs=.*/log\.dirs={$LOG_DIRS}/g" /opt/kafka/config/server.properties

# num.partitions=1
sed -i "s/num\.partitions=.*/num\.partitions=${NUM_PARTITIONS}/g" /opt/kafka/config/server.properties

# zookeeper.connect=localhost:2181
sed -i "s/zookeeper\.connect=.*/zookeeper\.connect=${ZOOKEEPER_CONNECT}/" /opt/kafka/config/server.properties

# group.initial.rebalance.delay.ms=0
sed -i "s/group\.initial\.rebalance\.delay\.ms=.*/group\.initial\.reblance\.delay\.ms=${GROUP_INITIAL_REBALANCE_DELAY_MS}/" /opt/kafka/config/server.properties

exec "$@"
