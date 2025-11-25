#!/bin/bash

# Build the image
echo "Building Docker image..."
docker build -t dotfiles-test .

# Run the container
echo "Running installation test..."
docker run --rm -it \
    -v $(pwd):/home/testuser/dotfiles \
    dotfiles-test \
    bash -c "cd ~/dotfiles && yes | ./install.sh"
