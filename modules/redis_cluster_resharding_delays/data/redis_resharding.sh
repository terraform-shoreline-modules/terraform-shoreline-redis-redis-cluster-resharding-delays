

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