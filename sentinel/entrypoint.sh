#!/bin/sh

# Wait for the master service to be available
until getent hosts redis-master || ping -c1 redis-master &>/dev/null; do
  echo "Waiting for master to be available..."
  sleep 1
done

# Resolve the master hostname to its IP address
MASTER_IP=$(getent hosts redis-master | awk '{ print $1 }' | head -n 1)

# If getent fails, try direct DNS lookup as a fallback
if [ -z "$MASTER_IP" ]; then
  echo "getent failed, trying nslookup"
  MASTER_IP=$(nslookup redis-master 2>/dev/null | grep -A 2 'Name:' | tail -n 1 | awk '{print $2}')
fi

echo "Master IP: $MASTER_IP"

# Check if MASTER_IP is empty
if [ -z "$MASTER_IP" ]; then
  echo "Error: Could not resolve master hostname. Using direct value."
  MASTER_IP="redis-master"
fi

# Replace environment variables in the config - notice the different syntax
sed -i "s/\$SENTINEL_QUORUM/$SENTINEL_QUORUM/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_DOWN_AFTER/$SENTINEL_DOWN_AFTER/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_FAILOVER/$SENTINEL_FAILOVER/g" /etc/redis/sentinel.conf
sed -i "s/\$HOST_NAME/$MASTER_IP/g" /etc/redis/sentinel.conf

# Start sentinel
exec redis-server /etc/redis/sentinel.conf --sentinel