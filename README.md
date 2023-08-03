
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Cassandra Node Unavailability
---

This incident type refers to a situation where a Cassandra node becomes unavailable. This can cause interruptions to the expected functionality of the system and can lead to data loss or corruption. The cause of this incident can be due to a variety of reasons such as hardware failure, network issues, or software bugs. It is critical to resolve the issue as soon as possible to minimize the impact on the system and ensure the smooth functioning of the application.

### Parameters
```shell
# Environment Variables

export CASSANDRA_NODE_IP_ADDRESS="PLACEHOLDER"

export PORT_NUMBER="PLACEHOLDER"

export BACKUP_FILE_NAME="PLACEHOLDER"

export RESTORE_DIRECTORY="PLACEHOLDER"

export CASSANDRA_DATA_LOCATION="PLACEHOLDER"

export BACKUP_LOCATION="PLACEHOLDER"
```

## Debug

### Check Cassandra service status
```shell
sudo service cassandra status
```

### Check Cassandra process status
```shell
ps aux | grep cassandra
```

### Check Cassandra system logs
```shell
tail -f /var/log/cassandra/system.log
```

### Check Cassandra node health
```shell
nodetool status
```

### Check Cassandra node ring information
```shell
nodetool ring
```

### Check Cassandra node gossip information
```shell
nodetool gossipinfo
```

### Check Cassandra node log for errors
```shell
tail -f /var/log/cassandra/system.log | grep ERROR
```

### Check Cassandra node log for warnings
```shell
tail -f /var/log/cassandra/system.log | grep WARN
```

### Check for any network connectivity issues
```shell
ping ${CASSANDRA_NODE_IP_ADDRESS}
```

### Check for any firewall issues
```shell
sudo iptables -L
```

## Repair

### Attempt to repair the Cassandra installation or reinstall it if necessary.
```shell


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

```

### Restore from a recent backup if data loss or corruption has occurred.
```shell

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

```

### Reboot the node to attempt to clear any software issues that may be causing the unavailability.
```shell

#!/bin/bash

NODE_IP=${NODE_IP_ADDRESS}

# Check if node is pingable

if ping -c1 $NODE_IP &> /dev/null

then

    echo "Node is pingable. Proceeding with reboot."

else

    echo "Node is not pingable. Aborting reboot."

    exit 1

fi

# Reboot node

ssh root@$NODE_IP 'reboot'

```

### Restore from a cassandra backup if data loss or corruption has occurred.
```shell

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

```