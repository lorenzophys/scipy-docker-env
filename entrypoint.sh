#!/bin/bash

if !(getent passwd ${HOST_USERNAME} > /dev/null 2>&1); then
    groupadd -g ${HOST_GID} ${HOST_USERNAME}
    useradd -l -u ${HOST_UID} -g ${HOST_USERNAME} ${HOST_USERNAME}
    usermod -a -G sudo ${HOST_USERNAME}
fi

chown ${HOST_USERNAME}:${HOST_USERNAME} /home/${HOST_USERNAME}

echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

tail -f /dev/null
