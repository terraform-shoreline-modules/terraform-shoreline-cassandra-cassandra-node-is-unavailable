
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