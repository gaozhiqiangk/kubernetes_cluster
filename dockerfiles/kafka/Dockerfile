FROM confluentinc/cp-base

ARG COMMIT_ID=unknow
LABEL io.confluent.docker.git.id=$COMMIT_ID
ARG BUILD_NUMBER=-1
LABEL io.confluent.docker.build.number=$BUILD_NUMBER

MAINTAAINER partner-support@confluent.io
LABEL io.confluent.docker=true

ARG KAFKA_ZOOKEEPER_CONNECT
ENV KAFKA_ZOOKEEPER_CONNECT=${KAFKA_ZOOKEEPER_CONNECT}
ARG KAFKA_ADVERTISED_LISTENERS
ENV KAFKA_ADVERTISED_LISTENERS=${KAFKA_ADVERTISED_LISTENERS}

ENV COMPONENT=kafka

EXPOSE 9092

RUN echo "===> install ${COMPONENT}..." \
    && apt-get update && apt-get install -y confluent-kafka-${SCALA_VERSION}=${KAFKA_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
    \
    && echo "===> clean up ..." \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* \
    \
    && echo "==-> Setting up ${COMPONENT} dirs.." \
    && mkdir -p /var/lib/${COMPONENT}/data /etc/${COMPONENT}/secrets \
    && chmod -R ag+w /etc/${COMPONENT} /var/lib/${COMPONENT}/data /etc/${COMPONENT}/secrets \
    && chown -R root:root /var/log/kafka /var/log/confluent /var/lib/kafka /var/lib/zookeeper

VOLUME ["/var/lib/${COMPONENT}/data", "/etc/${COMPONENT}/secrets"]

COPY include/etc/confluent/docker /etc/confluent/docker

CMD ["/etc/confluent/docker/run"]
