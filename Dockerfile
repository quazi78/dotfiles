FROM archlinux:latest

# Update system and install base requirements
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm git sudo base-devel

# Create a test user
RUN useradd -m -G wheel -s /bin/bash testuser && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to test user
USER testuser
WORKDIR /home/testuser

# Copy dotfiles (will be mounted or copied in test.sh)
# For now, we assume the repo is mounted at /home/testuser/dotfiles

CMD ["/bin/bash"]
