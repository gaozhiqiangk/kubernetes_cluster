FROM centos:7

ARG DISTRO_NAME=zookeeper-3.4.14

ENV DISTRO_NAME=$DISTRO_NAME \
          JAVA_HOME=/opt/java \
          PATH=/opt/java/bin:/opt/zookeeper/bin:$PATH \
          ZK_LOG_LEVEL=${ZK_LOG_LEVEL:-INFO} \
          ZK_USER=${ZK_USER:-zookeeper} \
          ZK_DATA_DIR=${ZK_DATA_DIR:-/var/zookeeper/data} \
          ZK_DATA_LOG_DIR=${ZK_DATA_LOG_DIR:-/var/zookeeper/log} \
          ZK_LOG_DIR=${ZK_LOG_DIR:-/var/log/zookeeper} \
          ZK_CONF_DIR=${ZK_CONF_DIR:-/opt/zookeeper/conf} \
          ZK_CLIENT_PORT=${ZK_CLIENT_PORT:-2181} \
          ZK_SERVER_PORT=${ZK_SERVER_PORT:-2888} \
          ZK_ELECTION_PORT=${ZK_ELECTION_PORT:-3888} \
          ZK_TICK_TIME=${ZK_TICK_TIME:-2000} \
          ZK_INIT_LIMIT=${ZK_INIT_LIMIT:-10} \
          ZK_SYNC_LIMIT=${ZK_SYNC_LIMIT:-5} \
          ZK_HEAP_SIZE=${ZK_HEAP_SIZE:-2G} \
          ZK_MAX_CLIENT_CNXNS=${ZK_MAX_CLIENT_CNXNS:-60} \
          #ZK_MIN_SESSION_TIMEOUT=${ZK_MIN_SESSION_TIMEOUT:- $((ZK_TICK_TIME*2))} \
          #ZK_MAX_SESSION_TIMEOUT=${ZK_MAX_SESSION_TIMEOUT:- $((ZK_TICK_TIME*20))} \
          ZK_SNAP_RETAIN_COUNT=${ZK_SNAP_RETAIN_COUNT:-3} \
          ZK_PURGE_INTERVAL=${ZK_PURGE_INTERVAL:-0} \
          ID_FILE="$ZK_DATA_DIR/myid" \
          ZK_CONFIG_FILE="$ZK_CONF_DIR/zoo.cfg" \
          LOGGER_PROPS_FILE="$ZK_CONF_DIR/log4j.properties" \
          JAVA_ENV_FILE="$ZK_CONF_DIR/java.env"
 
COPY entrypoint.sh /bin

RUN set -ex \
    && yum -y install wget vim lsof tar bzip2 unzip vim-enhanced passwd sudo yum-utils hostname \
          net-tools rsync man git make automake cmake patch logrotate python-devel libpng-devel \
          libjpeg-devel pwgen python-pip nc \
    && yum clean all \
    && mkdir -p /opt \
    && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
          https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz \
    && tar xf jdk-8u201-linux-x64.tar.gz -C /opt/ \
    && rm -rf jdk-8u201-linux-x64.tar.gz \
    && cd /opt \
    && ln -sv "$(ls | grep jdk[0-9].*)" java \
    && echo -e 'export JAVA_HOME=/opt/java\n \
       export PATH=$JAVA_HOME/bin:$PATH\n' \
       >> /etc/profile.d/java.sh \
    && source /etc/profile.d/java.sh \
    && wget -q "https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz" \
    && tar xf $DISTRO_NAME.tar.gz -C /opt/ \
    && rm -rf $DISTRO_NAME.tar.gz \
    && cd /opt \
    && ln -sv $DISTRO_NAME zookeeper \
    && echo 'PATH=/opt/zookeeper/bin:$PATH' > /etc/profile.d/zookeeper.sh \
    && source /etc/profile.d/zookeeper.sh \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/zoo.cfg \
    && useradd -u 1000 $ZK_USER \
    && mkdir -p $ZK_DATA_DIR $ZK_DATA_LOG_DIR $ZK_LOG_DIR $ZK_CONF_DIR \
    && chown $ZK_USER:$ZK_USER $ZK_DATA_DIR $ZK_DATA_LOG_DIR $ZK_LOG_DIR $ZK_CONF_DIR \
    && chmod +x /bin/entrypoint.sh \
    && echo '#!/bin/bash' > /opt/zookeeper/bin/zkOk.sh \
    && echo 'ZK_CLIENT_PORT=${ZK_CLIENT_PORT:-2181}' >> /opt/zookeeper/bin/zkOk.sh \
    && echo 'OK=$(echo ruok | nc 127.0.0.1 $ZK_CLIENT_PORT)' >> /opt/zookeeper/bin/zkOk.sh \
    && echo 'if [ "$OK" == "imok" ]; then' >> /opt/zookeeper/bin/zkOk.sh \
    && echo -e '\texit 0' >> /opt/zookeeper/bin/zkOk.sh \
    && echo 'else' >> /opt/zookeeper/bin/zkOk.sh \
    && echo -e '\texit 1' >> /opt/zookeeper/bin/zkOk.sh \
    && echo 'fi' >> /opt/zookeeper/bin/zkOk.sh \
    && chmod +x /opt/zookeeper/bin/zkOk.sh

#WORKDIR $DISTRO_NAME

VOLUME ["$ZK_DATA_DIR", "$ZK_DATA_LOG_DIR", "$ZK_LOG_DIR"]

EXPOSE $ZK_CLIENT_PORT $ZK_SERVER_PORT $ZK_ELECTION_PORT

ENTRYPOINT ["/bin/entrypoint.sh"]

#CMD /bin/bash
CMD ["/opt/zookeeper/bin/zkServer.sh", "start-foreground", "/opt/zookeeper/conf/zoo.cfg"]
