FROM openjdk:8-jre-alpine

ARG DISTRO_NAME=zookeeper-3.4.14

ENV PATH=$PATH:$ZK_ROOT_DIR/zookeeper/bin \
          ZK_USER=${ZK_USER:-"zookeeper"} \
          ZK_USER=${ZK_USER:-"zookeeper"} \
          ZK_LOG_LEVEL=${ZK_LOG_LEVEL:-"INFO"} \
          ZK_DATA_DIR=${ZK_DATA_DIR:-"/var/lib/zookeeper/data"} \
          ZK_DATA_LOG_DIR=${ZK_DATA_LOG_DIR:-"/var/lib/zookeeper/log"} \
          ZK_LOG_DIR=${ZK_LOG_DIR:-"/var/log/zookeeper"} \
          ZK_ROOT_DIR=${ZK_ROOT_DIR:-"/opt"} \
          ZK_CONF_DIR=${ZK_CONF_DIR:-"/opt/zookeeper/conf"} \
          ZK_CLIENT_PORT=${ZK_CLIENT_PORT:-2181} \
          ZK_SERVER_PORT=${ZK_SERVER_PORT:-2888} \
          ZK_ELECTION_PORT=${ZK_ELECTION_PORT:-3888} \
          ZK_TICK_TIME=${ZK_TICK_TIME:-2000} \
          ZK_INIT_LIMIT=${ZK_INIT_LIMIT:-10} \
          ZK_SYNC_LIMIT=${ZK_SYNC_LIMIT:-5} \
          ZK_HEAP_SIZE=${ZK_HEAP_SIZE:-2G} \
          ZK_MAX_CLIENT_CNXNS=${ZK_MAX_CLIENT_CNXNS:-60} \
          ZK_MIN_SESSION_TIMEOUT=${ZK_MIN_SESSION_TIMEOUT:-$((ZK_TICK_TIME*2))} \
          ZK_MAX_SESSION_TIMEOUT=${ZK_MAX_SESSION_TIMEOUT:-$((ZK_TICK_TIME*20))} \
          ZK_SNAP_RETAIN_COUNT=${ZK_SNAP_RETAIN_COUNT:-3} \
          ZK_PURGE_INTERVAL=${ZK_PURGE_INTERVAL:-0} \
          ID_FILE="$ZK_DATA_DIR/myid" \
          ZK_CONFIG_FILE="$ZK_CONF_DIR/zoo.cfg" \
          LOGGER_PROPS_FILE="$ZK_CONF_DIR/log4j.properties" \
          JAVA_ENV_FILE="$ZK_CONF_DIR/java.env"
 
COPY entrypoint.sh /
RUN set -ex \
    && echo 'https://mirrors.tuna.tsinghua.edu.cn/alpine/latest-stable/main/' > /etc/apk/repositories \
    && echo 'https://mirrors.tuna.tsinghua.edu.cn/alpine/latest-stable/community/' >> /etc/apk/repositories \
    && apk add --no-cache --virtual .build-deps \
          bash \
          su-exec \
    && adduser -D "$ZK_USER" \
    && mkdir -p "$ZK_DATA_DIR" "$ZK_DATA_LOG_DIR" "$ZK_LOG_DIR" "$ZK_CONF_DIR" \
    && chown "$ZK_USER:$ZK_USER" "$ZK_DATA_DIR" "$ZK_DATA_LOG_DIR" "$ZK_LOG_DIR" "$ZK_CONF_DIR" \
    ##&& wget -q "https://www.apache.org/dist/zookeeper/$DISTRO_NAME/$DISTRO_NAME.tar.gz" \
    && wget -q "https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz" \
    && tar -xf "$DISTRO_NAME.tar.gz" -C $ZK_ROOT_DIR \
    && rm -rf "$DISTRO_NAME.tar.gz" \
    && cd $ZK_ROOT_DIR \
    && ln -sv $DISTRO_NAME zookeeper \
    && apk del .build-deps \
    && chmod +x /entrypoint.sh

WORKDIR $DISTRO_NAME

VOLUME ["$ZK_DATA_DIR", "$ZK_DATA_LOG_DIR", "$ZK_LOG_DIR"]

EXPOSE $ZK_CLIENT_PORT $ZK_SERVER_PORT $ZK_ELECTION_PORT

ENTRYPOINT ["/entrypoint.sh"]

CMD ["zkServer.sh", "start-foreground"]
