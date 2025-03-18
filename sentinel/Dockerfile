FROM redis:latest

EXPOSE 26379
ADD sentinel.conf /etc/redis/sentinel.conf
RUN chown redis:redis /etc/redis/sentinel.conf
ENV SENTINEL_QUORUM=${SENTINEL_QUORUM:-2}
ENV SENTINEL_DOWN_AFTER=${SENTINEL_DOWN_AFTER:-30000}
ENV SENTINEL_FAILOVER=$SENTINEL_FAILOVER:-180000}
ENV HOST_NAME=${HOST_NAME:-redis-master}
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]