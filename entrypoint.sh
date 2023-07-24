#!/bin/bash

echo "$SSH_KEY_PRIVATE"|base64 -d > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

if [ "$TYPE" = "diff" ]; then
    ansible-playbook --diff -i ./inventory.yml playbook.yml && exit
fi
if [ "$TYPE" = "test" ]; then
    python3 /tester.py | bash && exit
fi
if [ "$TYPE" = "play" ]; then
    ansible-playbook -i ./inventory.yml playbook.yml && exit
else
    echo "Invalid env value - $TYPE"
    exit 1
fi
