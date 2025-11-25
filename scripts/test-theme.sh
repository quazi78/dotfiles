#!/bin/bash

# Theme Test Script
# Verifies that set-theme.sh correctly updates configuration files

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# Function to check if file contains string
check_content() {
    local file="$1"
    local string="$2"
    if grep -q "$string" "$file"; then
        print_success "Found '$string' in $file"
    else
        print_error "Missing '$string' in $file"
        exit 1
    fi
}

# Function to check symlink target
check_symlink() {
    local link="$1"
    local target="$2"
    if [[ "$(readlink "$link")" == *"$target"* ]]; then
        print_success "Symlink $link points to $target"
    else
        print_error "Symlink $link does not point to $target (Target: $(readlink "$link"))"
        exit 1
    fi
}

echo "Testing Theme Switching..."

# Test Catppuccin
echo -e "\n1. Switching to Catppuccin..."
./scripts/set-theme.sh catppuccin

# Verify Bat
check_content "bat/.config/bat/config" 'theme="Catppuccin Mocha"'

# Verify Yazi (symlink in home because install.sh stows it, but set-theme updates home link)
# Note: set-theme.sh updates $HOME/.config/yazi/theme.toml
check_symlink "$HOME/.config/yazi/theme.toml" "themes/catppuccin.toml"


# Test Kanagawa
echo -e "\n2. Switching to Kanagawa..."
./scripts/set-theme.sh kanagawa

# Verify Bat
check_content "bat/.config/bat/config" 'theme="Kanagawa"'

# Verify Yazi
check_symlink "$HOME/.config/yazi/theme.toml" "themes/kanagawa.toml"

echo -e "\n${GREEN}Theme switching tests passed!${NC}"
