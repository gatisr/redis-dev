# Redis Sentinel with RedisInsight for High Availability

## Overview

This directory contains a Docker Compose setup for Redis Sentinel, which provides high availability for Redis. The setup includes:

- A Redis master instance
- A Redis slave instance that replicates the master
- Multiple Redis Sentinel instances that monitor the master and slave
- RedisInsight for visualizing and managing your Redis instances

## First time configuration

### Run Redis Sentinel setup with docker-compose

```bash
docker-compose -p redis-sentinel up -d
```

### Open RedisInsight

[http://localhost:8001](http://localhost:8001)

## Connecting to Redis in RedisInsight

### Option 1: Connect directly to Redis master

1. In RedisInsight, click "Add Redis Database"
2. Select "Add Database" connection type
3. Enter the following details:
   - _Host:_ host.docker.internal (when running on same machine)
   - _Port:_ 6379
   - _Name:_ redis-sentinel-master
   - _Username/Password:_ (if configured)
4. Click "Add Redis Database"

### Create a new user (optional)

1. Open created Redis connection
2. Open `CLI` tab
3. Run `acl setuser <username> on >password> ~* +@all` command (e.g. `acl setuser sentinel-admin on >sentinel-pwd ~* +@all`)

## Sentinel Configuration

The Sentinel instances are configured with the following parameters:

- SENTINEL_QUORUM: 2 (default)
- SENTINEL_DOWN_AFTER: 5000ms (configurable via environment variables)
- SENTINEL_FAILOVER: 5000ms (configurable via environment variables)
