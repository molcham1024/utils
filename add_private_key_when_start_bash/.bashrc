PRIVATE_KEY="Enter the private key filename here."

eval `ssh-agent`

if [ ! $? -eq 0 ]; then
    echo "Warning: Failed to start ssh-agent."
	exit
fi

ssh-add ~/.ssh/${PRIVATE_KEY}

if [ ! $? -eq 0 ]; then
    echo "Warning: Failed to add private key \"${PRIVATE_KEY}\"."
	exit
fi