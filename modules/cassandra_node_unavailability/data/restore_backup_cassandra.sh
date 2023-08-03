
#!/bin/bash

# Specify the backup filename

BACKUP_FILE=${BACKUP_FILE_NAME}

# Specify the directory to restore the backup to

RESTORE_DIR=${RESTORE_DIRECTORY}


# Stop the Cassandra service

sudo systemctl stop cassandra

# Restore the backup

sudo tar -xzf $BACKUP_FILE -C $RESTORE_DIR


# start the Cassandra service

sudo systemctl start cassandra


# check the status of the Cassandra service

sudo systemctl status cassandra