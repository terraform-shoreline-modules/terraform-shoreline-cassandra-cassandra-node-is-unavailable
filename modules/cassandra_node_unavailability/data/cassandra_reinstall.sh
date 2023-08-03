

#!/bin/bash

# Stop Cassandra service

sudo service cassandra stop

# Remove Cassandra package

sudo apt-get remove cassandra

# Clean up any remaining files

sudo rm -rf /var/lib/cassandra

# Reinstall Cassandra

sudo apt-get install cassandra

# Start Cassandra service

sudo service cassandra start

# Check Cassandra status

sudo nodetool status