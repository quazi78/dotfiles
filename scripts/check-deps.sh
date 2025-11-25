#!/bin/bash

# Dependency Checker Script
# Checks if all required dependencies are installed

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}==>${NC} ${1}"
}

print_check() {
    if [ $2 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} ${1}"
    else
        echo -e "${RED}✗${NC} ${1}"
    fi
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo -e "${BLUE}Dotfiles Dependency Checker${NC}\n"

# Core tools
print_header "Core Tools"
command_exists nvim && print_check "Neovim" 0 || print_check "Neovim" 1
command_exists tmux && print_check "Tmux" 0 || print_check "Tmux" 1
command_exists fish && print_check "Fish Shell" 0 || print_check "Fish Shell" 1
command_exists git && print_check "Git" 0 || print_check "Git" 1
command_exists stow && print_check "GNU Stow" 0 || print_check "GNU Stow" 1

# CLI utilities
print_header "CLI Utilities"
command_exists rg && print_check "ripgrep" 0 || print_check "ripgrep" 1
command_exists fd && print_check "fd" 0 || print_check "fd" 1
command_exists bat && print_check "bat" 0 || print_check "bat" 1
command_exists fzf && print_check "fzf" 0 || print_check "fzf" 1

# Terminal Emulators
print_header "Terminal Emulators"
command_exists ghostty && print_check "Ghostty" 0 || print_check "Ghostty" 1

# Wayland ecosystem
print_header "Wayland Ecosystem"
command_exists waybar && print_check "Waybar" 0 || print_check "Waybar (optional)" 1
command_exists wofi && print_check "Wofi" 0 || print_check "Wofi (optional)" 1

# Development tools
print_header "Development Tools"
command_exists node && print_check "Node.js" 0 || print_check "Node.js (for Neovim LSP)" 1
command_exists npm && print_check "npm" 0 || print_check "npm (for Neovim LSP)" 1
command_exists python3 && print_check "Python 3" 0 || print_check "Python 3 (for Neovim)" 1
command_exists pip3 && print_check "pip3" 0 || print_check "pip3 (for Neovim)" 1
command_exists gcc && print_check "GCC" 0 || print_check "GCC (for Treesitter)" 1

# Oh My Zsh
print_header "Shell Enhancements"
[ -d "$HOME/.oh-my-zsh" ] && print_check "Oh My Zsh" 0 || print_check "Oh My Zsh (optional)" 1

echo
echo -e "${BLUE}Note:${NC} Items marked as 'optional' are not required but enhance functionality."
echo -e "Run ${GREEN}./install.sh${NC} to install missing dependencies."
