# ⌨️ Keybindings Reference

Complete keybinding reference for all tools in this dotfiles configuration.

## Neovim

### General

| Binding | Mode | Action |
|---------|------|--------|
| `Space` | Normal | Leader key |
| `;` | Normal | Enter command mode (`:`) |
| `Tab` | Normal | Next buffer |
| `Space + ?` | Normal | Show keybindings (which-key) |

### File Navigation

| Binding | Mode | Action |
|---------|------|--------|
| `Ctrl + p` | Normal | Find files (Telescope) |
| `Space + fg` | Normal | Live grep search (Telescope) |
| `Ctrl + n` | Normal | Toggle file tree (Neo-tree) |
| `Space + bf` | Normal | Show buffers (Neo-tree float) |

### Pane Navigation (Tmux Integration)

| Binding | Mode | Action |
|---------|------|--------|
| `Ctrl + h` | Normal | Move to left pane (vim/tmux) |
| `Ctrl + j` | Normal | Move to pane below (vim/tmux) |
| `Ctrl + k` | Normal | Move to pane above (vim/tmux) |
| `Ctrl + l` | Normal | Move to right pane (vim/tmux) |
| `Ctrl + \` | Normal | Move to previous pane |

### Telescope (Fuzzy Finder)

| Binding | Mode | Action |
|---------|------|--------|
| `Ctrl + j` | Insert | Next result |
| `Ctrl + k` | Insert | Previous result |
| `Enter` | Insert | Open file |
| `Ctrl + x` | Insert | Open in horizontal split |
| `Ctrl + v` | Insert | Open in vertical split |
| `Esc` | Insert | Close Telescope |

### Neo-tree (File Explorer)

| Binding | Mode | Action |
|---------|------|--------|
| `a` | Normal | Add file/directory |
| `d` | Normal | Delete |
| `r` | Normal | Rename |
| `c` | Normal | Copy |
| `x` | Normal | Cut |
| `p` | Normal | Paste |
| `R` | Normal | Refresh |
| `H` | Normal | Toggle hidden files |
| `Enter` | Normal | Open file/expand directory |

---



## Tmux

**Prefix**: `Ctrl + a`

### Pane Management

| Binding | Action |
|---------|--------|
| `Prefix + \|` | Split horizontal |
| `Prefix + -` | Split vertical |
| `Prefix + h` | Focus left pane |
| `Prefix + j` | Focus pane below |
| `Prefix + k` | Focus pane above |
| `Prefix + l` | Focus right pane |
| `Prefix + H` | Resize pane left |
| `Prefix + J` | Resize pane down |
| `Prefix + K` | Resize pane up |
| `Prefix + L` | Resize pane right |

### Window Management

| Binding | Action |
|---------|--------|
| `Prefix + c` | Create new window |
| `Prefix + n` | Next window |
| `Prefix + p` | Previous window |
| `Prefix + 0-9` | Switch to window 0-9 |
| `Prefix + ,` | Rename window |
| `Prefix + &` | Kill window |

### Session Management

| Binding | Action |
|---------|--------|
| `Prefix + d` | Detach from session |
| `Prefix + $` | Rename session |
| `Prefix + s` | List sessions |
| `Prefix + (` | Previous session |
| `Prefix + )` | Next session |

### Copy Mode

| Binding | Action |
|---------|--------|
| `Prefix + [` | Enter copy mode |
| `Prefix + ]` | Paste buffer |
| `Prefix + Space` | Choose buffer |
| `v` (in copy mode) | Begin selection |
| `y` (in copy mode) | Copy selection |
| `q` (in copy mode) | Exit copy mode |

### Misc

| Binding | Action |
|---------|--------|
| `Prefix + r` | Reload tmux config |
| `Prefix + ?` | Show all keybindings |
| `Prefix + t` | Show time |
| `Prefix + a` | Send prefix to nested tmux |

---

## Fish Shell

### Autosuggestions & History

| Binding | Action |
|---------|--------|
| `Right Arrow` | Accept autosuggestion |
| `Ctrl + f` | Accept autosuggestion (same as right arrow) |
| `Up Arrow` | Search history (matching current command) |
| `Alt + .` | Insert last argument of previous command |
| `Tab` | Complete command/path |

### Zoxide (Smart cd)

| Binding | Action |
|---------|--------|
| `z <dir>` | Jump to directory |
| `zi` | Interactive selection (with fzf) |

---



## Tips

### Muscle Memory Consistency

Notice how navigation is consistent across tools:
- **Vim/Tmux**: `Ctrl + h/j/k/l` works seamlessly
- **Tmux panes**: Same as vim navigation

### Discovering More Keybindings

- **Neovim**: Press `Space + ?` for which-key popup
- **Tmux**: Press `Prefix + ?` for help
- **Fish**: `bind` command lists all bindings

### Custom Keybindings

To add your own:
- **Neovim**: Edit `init.lua` or create plugin configs
- **Tmux**: Edit `tmux/.config/tmux/tmux.conf`
- **Fish**: Edit `fish/.config/fish/config.fish`

---

**Last Updated**: 2025-11-25
