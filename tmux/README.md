# Tmux Configuration

This directory contains tmux configuration using the XDG Base Directory standard.

## Plugin Manager

This configuration uses [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm) to manage plugins.

### First-Time Setup

1. **Install TPM**:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
   ```

2. **Start tmux**:
   ```bash
   tmux
   ```

3. **Install plugins**:
   Press `Prefix + I` (that's `Ctrl+a` then `Shift+i`) to fetch and install plugins.

### Installed Plugins

- **tpm** - Tmux Plugin Manager
- **tmux-sensible** - Sensible tmux defaults
- **vim-tmux-navigator** - Seamless navigation between vim and tmux panes
- **tmux-yank** - Copy to system clipboard
- **tmux-kanagawa** - Kanagawa theme for tmux

### Managing Plugins

- **Install plugins**: `Prefix + I`
- **Update plugins**: `Prefix + U`
- **Remove/uninstall plugins**: `Prefix + alt + u`

### Note

The `plugins/` directory is gitignored and managed by TPM. Do not commit plugin contents to the repository.
