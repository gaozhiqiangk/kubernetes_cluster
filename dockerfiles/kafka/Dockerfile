FROM openjdk:8-jre-alpine

LABEL maintainer="gaozhiqiang <gaozhiqiang@solomonlinux.com>"

ARGS SCALA_VERSION="2.12" \
          KAFKA_VERSION="2.2.0"

ENV POD_NAME \
          POD_NAMESPACE \
          KAFKA_HEAP_OPTS \
          KAFKA_ZOOKEEPER_CONNECT \
          KAFKA_LOG_DIRS \
          KAFKA_CONFLUENT_SUPPORT_METRICS_ENABLE \
          KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR \
          KAFKA_JMX_PORT

RUN apk add --no-cache --virtual .build-deps \
          curl \
    && curl -fsSL http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && mkdir -p /opt \
    && tar xf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
    && mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka

ADD entrypoint.sh /bin/

EXPOSE 9092

CMD ["/opt/kafka/kafka-server-start.sh", "server.properties"]

ENTRYPOINT ["/bin/entrypoint.sh"]

#ENTRYPOINT ["sh", "/usr/local/kafka/bin/kafka-server-start.sh", "/usr/local/kafka/config/server.proties"]

#curl -fsSL http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -o kafka.tgz
