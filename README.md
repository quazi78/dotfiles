# 🚀 Dotfiles

> Modern, modular dotfiles for Arch Linux featuring Neovim, i3/Hyprland, and a beautiful terminal setup.

[![OS](https://img.shields.io/badge/OS-Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff)](https://archlinux.org/)
[![Shell](https://img.shields.io/badge/Shell-Zsh-89e051?logo=gnu-bash&logoColor=fff)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/Editor-Neovim-57A143?logo=neovim&logoColor=fff)](https://neovim.io/)
[![WM](https://img.shields.io/badge/WM-i3%20%2F%20Hyprland-orange)](https://i3wm.org/)

## ✨ Features

- 🎨 **Beautiful Aesthetics**: Kanagawa colorscheme with custom i3 theme
- ⚡ **Modern Neovim**: Lua-based configuration with lazy.nvim plugin manager
- 🪟 **Flexible Window Management**: Support for both i3 (X11) and Hyprland (Wayland)
- 🔍 **Powerful Search**: Telescope fuzzy finder with ripgrep integration
- 📁 **Smart File Navigation**: Neo-tree file explorer with git integration
- 🎯 **Seamless Tmux Integration**: Navigate between vim and tmux panes effortlessly
- 🚀 **Fast Terminal**: Alacritty and Kitty configurations included
- 🎭 **Multiple Themes**: Kanagawa, Catppuccin, and Darkfox colorschemes

## 🛠️ Included Tools

- **Neovim**: Advanced text editor with a comprehensive Lua configuration.
- **Tmux**: Terminal multiplexer for managing multiple sessions.
- **Fish**: Smart and user-friendly command line shell.
- **Ghostty**: Fast, GPU-accelerated terminal emulator.
- **Bat**: A `cat` clone with syntax highlighting and Git integration.

## 📦 Dependencies

### Arch Linux
```bash
sudo pacman -S neovim tmux fish git ripgrep fd bat fzf ghostty
```

### Debian/Ubuntu
```bash
sudo apt install neovim tmux fish git ripgrep fd-find bat fzf
# Ghostty installation may vary
```

### macOS
```bash
brew install neovim tmux fish git ripgrep fd bat fzf ghostty
```

### Neovim Dependencies
```bash
# Required for plugins
sudo pacman -S nodejs npm python python-pip

# Telescope dependencies
sudo pacman -S ripgrep fd

# Treesitter dependencies
sudo pacman -S tree-sitter gcc
```

### i3 Desktop Environment
```bash
# i3 ecosystem
sudo pacman -S i3-wm i3status i3lock rofi polybar picom dunst

# System utilities
sudo pacman -S nm-applet xfce-polkit xss-lock

# Fonts (required for icons)
sudo pacman -S ttf-meslo-nerd ttf-nerd-fonts-symbols
```

### Hyprland Desktop Environment
```bash
# Hyprland ecosystem
sudo pacman -S hyprland waybar wofi dunst

# Additional Wayland tools
sudo pacman -S xdg-desktop-portal-hyprland
```

### Optional Enhancements
```bash
# Oh My Zsh (install separately)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh My Posh (for advanced prompts)
sudo pacman -S oh-my-posh
```

## 🚀 Installation

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Checkout the nvim branch**
   ```bash
   git checkout nvim
   ```

3. **Run the installation script**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

   The script will:
   - Check for and install GNU Stow if needed
   - Detect your system and install dependencies
   - Backup existing configurations
   - Create symlinks using Stow
   - Install Neovim plugins automatically

### Manual Installation

If you prefer manual control:

1. **Install GNU Stow**
   ```bash
   sudo pacman -S stow
   ```

2. **Backup existing configs**
   ```bash
   mkdir -p ~/.config-backup
   mv ~/.config/nvim ~/.config-backup/ 2>/dev/null || true
   mv ~/.config/i3 ~/.config-backup/ 2>/dev/null || true
   # ... backup other configs as needed
   ```

3. **Stow individual packages**
   ```bash
   # Install all configs
   stow */

   # Or install selectively
   stow nvim
   stow i3
   stow tmux
   stow zshrc
   ```

4. **Install Neovim plugins**
   ```bash
   nvim --headless "+Lazy! sync" +qa
   ```

## ⌨️ Key Bindings

### Neovim

**Leader Key**: `Space`

| Binding | Action |
|---------|--------|
| `Space + ?` | Show all keybindings (which-key) |
| `Ctrl + p` | Find files (Telescope) |
| `Space + fg` | Live grep (Telescope) |
| `Ctrl + n` | Toggle file tree (Neo-tree) |
| `Space + bf` | Show buffers (Neo-tree) |
| `Tab` | Next buffer |
| `;` | Command mode (`:`) |
| `Ctrl + h/j/k/l` | Navigate vim/tmux panes |

### i3 Window Manager

**Mod Key**: `Super` (Windows key)

| Binding | Action |
|---------|--------|
| `Mod + Return` | Open terminal (Alacritty) |
| `Mod + d` | Application launcher (Rofi) |
| `Mod + Space` | Quick launcher (Rofi combi) |
| `Mod + Tab` | Window switcher (Rofi) |
| `Mod + Shift + q` | Kill window |
| `Mod + h` | Split horizontal |
| `Mod + v` | Split vertical |
| `Mod + f` | Fullscreen |
| `Mod + 1-9` | Switch workspace |
| `Mod + Shift + 1-9` | Move to workspace |
| `Mod + r` | Resize mode |

### Tmux

**Prefix**: `Ctrl + a`

| Binding | Action |
|---------|--------|
| `Prefix + h/j/k/l` | Navigate panes |
| `Prefix + H/J/K/L` | Resize panes |
| `Prefix + \|` | Split horizontal |
| `Prefix + -` | Split vertical |
| `Prefix + r` | Reload config |
| `Prefix + [` | Copy mode |
| `Prefix + ]` | Paste |

See [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md) for the complete reference.

## 🎨 Customization

### Changing Neovim Colorscheme

Edit `nvim/.config/nvim/init.lua`:
```lua
-- Change from kanagawa to catppuccin or darkfox
vim.cmd.colorscheme "catppuccin"
```

Available themes:
- `kanagawa` (default) - Warm, Japanese-inspired
- `catppuccin` - Pastel, soothing colors
- `darkfox` - Dark, high contrast

### Adding Neovim Plugins

Create a new file in `nvim/.config/nvim/lua/plugins/`:
```lua
-- nvim/.config/nvim/lua/plugins/myplugin.lua
return {
  'author/plugin-name',
  config = function()
    -- Plugin configuration
  end
}
```

Lazy.nvim will automatically load it on next startup.

### Customizing i3 Colors

Edit `i3/.config/i3/config` and modify the color scheme section (lines 197-205).

## 📚 Documentation

- [PLUGINS.md](PLUGINS.md) - Detailed Neovim plugin documentation
- [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md) - Complete keybinding reference
- [Neovim Configuration Guide](https://neovim.io/doc/user/)
- [i3 User Guide](https://i3wm.org/docs/userguide.html)

## 🔍 Troubleshooting

### Neovim plugins not loading
```bash
# Reinstall plugins
nvim --headless "+Lazy! sync" +qa

# Or manually inside Neovim
:Lazy sync
```

### Icons not showing
Install a Nerd Font:
```bash
sudo pacman -S ttf-meslo-nerd
# Set your terminal to use "MesloLGS Nerd Font"
```

### Tmux navigator not working
Ensure you have the tmux plugin installed:
```bash
# The config will auto-install via TPM on first run
# Or manually: Prefix + I
```

### Stow conflicts
If stow reports conflicts:
```bash
# Remove or backup the conflicting file
mv ~/.config/nvim ~/.config/nvim.backup

# Then re-run stow
stow nvim
```

## 🤝 Contributing

Feel free to fork and customize! If you have improvements or find bugs, pull requests are welcome.

## 📝 License

MIT License - feel free to use and modify as you wish.

## 🙏 Credits

Inspired by the amazing dotfiles community and various configurations from:
- [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)
- The broader r/unixporn community

---

**Note**: This configuration is optimized for Arch Linux but should work on most Linux distributions with minor adjustments.
