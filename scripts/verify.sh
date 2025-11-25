#!/bin/bash

# Verification Script
# Checks if dotfiles are correctly symlinked and tools are installed

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

errors=0

check_link() {
    local target="$1"
    if [ -L "$target" ]; then
        print_success "Symlink exists: $target"
    else
        print_error "Missing symlink: $target"
        errors=$((errors + 1))
    fi
}

check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        print_success "Command found: $1"
    else
        print_error "Command missing: $1"
        errors=$((errors + 1))
    fi
}

echo "Verifying Symlinks..."
check_link "$HOME/.config/nvim"
check_link "$HOME/.config/fish"
check_link "$HOME/.config/ghostty"
check_link "$HOME/.config/tmux"
check_link "$HOME/.config/bat"
if [ -f "$HOME/.config/ripgrep/.ripgreprc" ]; then
    print_success "Config exists: $HOME/.config/ripgrep/.ripgreprc"
else
    print_error "Missing config: $HOME/.config/ripgrep/.ripgreprc"
    errors=$((errors + 1))
fi
check_link "$HOME/.config/yazi"
check_link "$HOME/.gitconfig"

echo -e "\nVerifying Tools..."
check_command nvim
check_command fish
if command -v ghostty >/dev/null 2>&1; then
    print_success "Command found: ghostty"
else
    echo -e "${YELLOW}!${NC} Command missing: ghostty (Expected in headless/CI environments)"
fi
check_command tmux
if command -v bat >/dev/null 2>&1 || command -v batcat >/dev/null 2>&1; then
    print_success "Command found: bat (or batcat)"
else
    print_error "Command missing: bat"
    errors=$((errors + 1))
fi
check_command rg
if command -v yazi >/dev/null 2>&1; then
    print_success "Command found: yazi"
else
    echo -e "${YELLOW}!${NC} Command missing: yazi (Install manually if not in repos)"
fi

if command -v delta >/dev/null 2>&1; then
    print_success "Command found: delta"
else
    echo -e "${YELLOW}!${NC} Command missing: delta (Install manually if not in repos)"
fi
check_command zoxide

if [ $errors -eq 0 ]; then
    echo -e "\n${GREEN}All checks passed!${NC}"
    exit 0
else
    echo -e "\n${RED}Found $errors error(s).${NC}"
    exit 1
fi
