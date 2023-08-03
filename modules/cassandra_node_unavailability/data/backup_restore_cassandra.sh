
#!/bin/bash

# Set the variables

BACKUP_LOCATION=${BACKUP_LOCATION}

CASSANDRA_DATA_LOCATION=${CASSANDRA_DATA_LOCATION}

# Stop the Cassandra service

service cassandra stop

# Restore the backup

cp -r $BACKUP_LOCATION/* $CASSANDRA_DATA_LOCATION/

# Start the Cassandra service

service cassandra start

# Verify that Cassandra is running normally

nodetool status