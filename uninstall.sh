#!/bin/bash

# Dotfiles Uninstallation Script
# Safely removes dotfiles symlinks and optionally restores backups

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}==>${NC} ${1}"
}

print_success() {
    echo -e "${GREEN}✓${NC} ${1}"
}

print_error() {
    echo -e "${RED}✗${NC} ${1}"
}

print_warning() {
    echo -e "${YELLOW}!${NC} ${1}"
}

print_info() {
    echo -e "  ${1}"
}

# Check if stow is installed
if ! command -v stow >/dev/null 2>&1; then
    print_error "GNU Stow is not installed. Cannot proceed with uninstallation."
    exit 1
fi

# Main uninstallation
main() {
    echo -e "${BLUE}"
    cat << "EOF"
    __  __      _           __        ____
   / / / /___  (_)___  _____/ /_____ _/ / /
  / / / / __ \/ / __ \/ ___/ __/ __ `/ / / 
 / /_/ / / / / / / / (__  ) /_/ /_/ / / /  
 \____/_/ /_/_/_/ /_/____/\__/\__,_/_/_/   
                                            
EOF
    echo -e "${NC}"
    
    print_header "Dotfiles Uninstallation"
    print_warning "This will remove all dotfiles symlinks created by Stow"
    echo
    
    read -p "Are you sure you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Uninstallation cancelled"
        exit 0
    fi
    
    # Check if we're in the dotfiles directory
    if [ ! -f "README.md" ] || [ ! -d "nvim" ]; then
        print_error "Please run this script from the dotfiles directory"
        exit 1
    fi
    
    print_header "Removing symlinks"
    
    # Get list of stowable directories
    local packages=()
    for dir in */; do
        dir=${dir%/}
        if [[ ! "$dir" =~ ^\. ]] && [ "$dir" != "docs" ] && [ "$dir" != "scripts" ]; then
            packages+=("$dir")
        fi
    done
    
    # Unstow each package
    for package in "${packages[@]}"; do
        print_info "Unstowing: $package"
        if stow -t "$HOME" -D "$package" 2>/dev/null; then
            print_success "Removed: $package"
        else
            print_warning "Could not remove: $package (may not be stowed)"
        fi
    done
    
    # Ask about restoring backups
    print_header "Restore Backups"
    
    # Find backup directories
    local backups=($(find "$HOME" -maxdepth 1 -type d -name ".config-backup-*" 2>/dev/null | sort -r))
    
    if [ ${#backups[@]} -eq 0 ]; then
        print_info "No backup directories found"
    else
        print_info "Found ${#backups[@]} backup(s):"
        for i in "${!backups[@]}"; do
            echo "  $((i+1)). ${backups[$i]}"
        done
        
        read -p "Restore a backup? Enter number (or N to skip): " -r
        if [[ $REPLY =~ ^[0-9]+$ ]] && [ $REPLY -ge 1 ] && [ $REPLY -le ${#backups[@]} ]; then
            backup_dir="${backups[$((REPLY-1))]}"
            print_info "Restoring from: $backup_dir"
            
            for item in "$backup_dir"/*; do
                if [ -e "$item" ]; then
                    basename=$(basename "$item")
                    if [ "$basename" = ".zshrc" ]; then
                        cp -r "$item" "$HOME/"
                        print_success "Restored: $basename to ~/"
                    else
                        cp -r "$item" "$HOME/.config/"
                        print_success "Restored: $basename to ~/.config/"
                    fi
                fi
            done
        else
            print_info "Skipping backup restoration"
        fi
    fi
    
    echo
    print_header "Uninstallation Complete"
    print_success "Dotfiles symlinks have been removed"
    echo
    print_info "Your dotfiles repository is still intact in $(pwd)"
    print_info "You can reinstall anytime by running ./install.sh"
}

main
