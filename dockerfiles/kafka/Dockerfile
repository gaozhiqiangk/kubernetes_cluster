FROM openjdk:8-jre-alpine

LABEL maintainer="gaozhiqiang <gaozhiqiang@solomonlinux.com>"

ENV SCALA_VERSION="2.12" \
          KAFKA_VERSION="2.2.0"

RUN apk add --no-cache --virtual .build-deps \
          curl \
    && curl -fsSL http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -o kafka.tgz
    && tar xf kafka.tgz -C /usr/local/bin

EXPOSE 9092

ENTRYPOINT ["sh", "/usr/local/kafka/bin/kafka-server-start.sh", "/usr/local/kafka/config/server.proties"]
