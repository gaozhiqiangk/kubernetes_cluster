FROM centos:7

LABEL maintainer="gaozhiqiang <gaozhiqiang@solomonlinux.com>"

ARGS SCALA_VERSION="2.12" \
          KAFKA_VERSION="2.2.0"

ENV SCALA_VERSION="2.12" \
          KAFKA_VERSION="2.2.0" \
          JAVA_HOME=/opt/java \
          PATH=/opt/kafka/bin:$PATH \

COPY entrypoint.sh /bin

RUN set -e \
    && yum -y install vim lsof wget tar bzip2 unzip vim-enhanced passwd sudo yum-utils hostname net-tools rsync man git make automake \
          cmake patch logrotate python-devel libpng-devel libjpeg-devel pwgen python-pip \
    && yum clean all \
    && mkdir -p /opt \
    && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
          https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz \
    && tar xf jdk-8u201-linux-x64.tar.gz -C /opt/ \
    && rm -rf jdk-8u201-linux-x64.tar.gz \
    && cd /opt \
    && ln -sv "$(ls | grep jdk[0-9].*)" java \
    && echo 'export JAVA_HOME=/opt/java' > /etc/profile.d/java.sh \
    && echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/java.sh \
    && source /etc/profile.d/java.sh \
    && wget http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && tar xf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt/ \
    && rm -rf kafka_${SCAlA_VERSION}-${KAFKA_VERSION}.tgz
    && cd /opt \
    && ln -sv kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz kafka \
    && echo 'export PATH=/opt/kafka/bin:$PATH' > /etc/profile.d/kafka.sh \
    && source /etc/profile.d/kafka.sh \
    && useradd -u 1000 kafka \
    && chown -R kafka:kafka /opt/kafka
    && chown -R kafka:kafka /opt/kafka/
    && chmod +x /bin/entrypoint.sh

EXPOSE 9092

ENTRYPOINT ["entrypoint.sh"]

CMD ["kafka-server-start.sh", "/opt/kafka/conf/server.properties"]


ENV POD_NAME \
          POD_NAMESPACE \
          KAFKA_HEAP_OPTS \
          KAFKA_ZOOKEEPER_CONNECT \
          KAFKA_LOG_DIRS \
          KAFKA_CONFLUENT_SUPPORT_METRICS_ENABLE \
          KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR \
          KAFKA_JMX_PORT

