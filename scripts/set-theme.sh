#!/bin/bash

# Theme Switcher Script
# Switches color themes across Neovim, Tmux, and Ghostty

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

THEME=$1

if [ -z "$THEME" ]; then
    echo -e "${RED}Usage: $0 <theme>${NC}"
    echo "Available themes: kanagawa, catppuccin"
    exit 1
fi

echo -e "${BLUE}Switching to theme: ${GREEN}$THEME${NC}"

# 1. Update Ghostty
if [ -f "$HOME/.config/ghostty/themes/$THEME" ]; then
    echo "Updating Ghostty..."
    ln -sf "themes/$THEME" "$HOME/.config/ghostty/themes/current"
    # Ghostty auto-reloads config
else
    echo -e "${RED}Warning: Ghostty theme '$THEME' not found${NC}"
fi

# 4. Update Neovim
# 4. Update Neovim
echo "Updating Neovim..."
# Check if we are in the dotfiles repo
if [ -f "nvim/.config/nvim/init.lua" ]; then
    NVIM_CONFIG="nvim/.config/nvim/init.lua"
else
    NVIM_CONFIG="$HOME/.config/nvim/init.lua"
fi
if [ "$THEME" == "kanagawa" ]; then
    sed -i 's/vim.cmd.colorscheme ".*"/vim.cmd.colorscheme "kanagawa"/' "$NVIM_CONFIG"
elif [ "$THEME" == "catppuccin" ]; then
    sed -i 's/vim.cmd.colorscheme ".*"/vim.cmd.colorscheme "catppuccin"/' "$NVIM_CONFIG"
fi

# 5. Update Tmux
# 5. Update Tmux
echo "Updating Tmux..."
if [ -f "tmux/.config/tmux/tmux.conf" ]; then
    TMUX_CONFIG="tmux/.config/tmux/tmux.conf"
else
    TMUX_CONFIG="$HOME/.config/tmux/tmux.conf"
fi
if [ "$THEME" == "kanagawa" ]; then
    # Comment out catppuccin, uncomment kanagawa
    sed -i 's/^set -g @plugin .*catppuccin-tmux.*/# &/' "$TMUX_CONFIG"
    sed -i 's/^# set -g @plugin .*catppuccin-tmux.*/# set -g @plugin \x27dreamsofcode-io\/catppuccin-tmux\x27/' "$TMUX_CONFIG" # Normalize
    
    # Enable Kanagawa
    sed -i 's/^# set -g @plugin .*tmux-kanagawa.*/set -g @plugin \x27Nybkox\/tmux-kanagawa\x27/' "$TMUX_CONFIG"
    sed -i 's/^set -g @plugin .*tmux-kanagawa.*/set -g @plugin \x27Nybkox\/tmux-kanagawa\x27/' "$TMUX_CONFIG"
    
elif [ "$THEME" == "catppuccin" ]; then
    # Comment out kanagawa
    sed -i 's/^set -g @plugin .*tmux-kanagawa.*/# &/' "$TMUX_CONFIG"
    
    # Enable Catppuccin
    sed -i 's/^# set -g @plugin .*catppuccin-tmux.*/set -g @plugin \x27dreamsofcode-io\/catppuccin-tmux\x27/' "$TMUX_CONFIG"
fi

# 6. Update Bat
echo "Updating Bat..."
if [ -f "bat/.config/bat/config" ]; then
    BAT_CONFIG="bat/.config/bat/config"
else
    BAT_CONFIG="$HOME/.config/bat/config"
fi

if [ "$THEME" == "kanagawa" ]; then
    sed -i 's/--theme=".*/--theme="Kanagawa"/' "$BAT_CONFIG"
elif [ "$THEME" == "catppuccin" ]; then
    sed -i 's/--theme=".*/--theme="Catppuccin Mocha"/' "$BAT_CONFIG"
fi

# Rebuild bat cache if bat is installed
if command -v bat >/dev/null 2>&1; then
    bat cache --build >/dev/null 2>&1 || true
fi

# Reload tmux if running
if pgrep tmux >/dev/null; then
    tmux source "$TMUX_CONFIG" 2>/dev/null || true
    # Re-install plugins to ensure theme is loaded
    "$HOME/.config/tmux/plugins/tpm/bin/install_plugins" >/dev/null 2>&1 || true
fi

echo -e "${GREEN}Theme switched to $THEME!${NC}"
