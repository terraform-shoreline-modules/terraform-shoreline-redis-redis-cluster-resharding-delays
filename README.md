
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Redis Cluster Resharding Delays.
---
Redis Cluster Resharding Delays occur when the process of redistributing data across Redis cluster nodes takes longer than expected. This can lead to slow resharding operations and may cause performance issues for applications that rely on the Redis database. In such instances, it is important to investigate the root cause of the delays and take necessary actions to restore normal performance.

### Parameters
```shell
export REDIS_HOST="PLACEHOLDER"

export REDIS_PORT="PLACEHOLDER"

export PATH_TO_REDIS_CONFIG_FILE="PLACEHOLDER"
```

## Debug

### Check Redis cluster status and get the node IDs
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} cluster nodes
```

### Check CPU usage of Redis nodes
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} info cpu
```

### Check memory usage of Redis nodes
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} info memory
```

### Check network latency between Redis nodes
```shell
redis-cli --latency -h ${REDIS_HOST} -p ${REDIS_PORT}
```

### Check for slow Redis commands
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} slowlog get
```

## Repair

### Optimize the resharding algorithm: Redis provides various resharding algorithms that can be used to optimize the resharding process. Choosing the right algorithm based on the cluster's specific needs may help to improve performance.
```shell


#!/bin/bash



REDIS_CONFIG_FILE=${PATH_TO_REDIS_CONFIG_FILE}



# Check if Redis config file exists

if [ ! -f "$REDIS_CONFIG_FILE" ]; then

    echo "Redis config file not found at $REDIS_CONFIG_FILE"

    exit 1

fi



# Check if Redis server is running

REDIS_PID=$(pidof redis-server)

if [ -z "$REDIS_PID" ]; then

    echo "Redis server is not running"

    exit 1

fi



# Stop Redis server

sudo systemctl stop redis



# Edit Redis config file to set resharding algorithm

sudo sed -i 's/redis.resharding.algorithm =.*$/redis.resharding.algorithm = optimized/' $REDIS_CONFIG_FILE



# Start Redis server

sudo systemctl start redis



echo "Redis resharding algorithm has been optimized"


```