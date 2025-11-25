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

## i3 Window Manager

**Mod Key**: `Super` (Windows key)

### Application Launching

| Binding | Action |
|---------|--------|

| Binding | Action |
|---------|--------|
| `Mod + Shift + c` | Reload i3 config |
| `Mod + Shift + r` | Restart i3 (preserves session) |
| `Mod + Shift + e` | Exit i3 |

### Media Keys

| Binding | Action |
|---------|--------|
| `XF86AudioRaiseVolume` | Volume up 10% |
| `XF86AudioLowerVolume` | Volume down 10% |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioMicMute` | Toggle mic mute |

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

## Zsh

### Oh My Zsh Defaults

| Binding | Action |
|---------|--------|
| `Ctrl + r` | Search command history |
| `Ctrl + a` | Move to start of line |
| `Ctrl + e` | Move to end of line |
| `Ctrl + u` | Clear line before cursor |
| `Ctrl + k` | Clear line after cursor |
| `Ctrl + w` | Delete word before cursor |
| `Alt + .` | Insert last argument |
| `!!` | Repeat last command |
| `!$` | Last argument of previous command |

### Custom Aliases

Check `zshrc/.zshrc` for custom aliases specific to your setup.

---

## Rofi

### Application Launcher

| Binding | Action |
|---------|--------|
| `Enter` | Launch selected application |
| `Shift + Enter` | Launch in terminal |
| `Ctrl + Enter` | Launch as root |
| `Esc` | Close Rofi |
| `Type to search` | Filter applications |

### Window Switcher

| Binding | Action |
|---------|--------|
| `Enter` | Switch to window |
| `Shift + Delete` | Close window |
| `Esc` | Cancel |

---

## Tips

### Muscle Memory Consistency

Notice how navigation is consistent across tools:
- **Vim/Tmux**: `Ctrl + h/j/k/l` works seamlessly
- **i3**: `Mod + j/k/l/;` mirrors vim movement
- **Tmux panes**: Same as vim navigation

### Discovering More Keybindings

- **Neovim**: Press `Space + ?` for which-key popup
- **i3**: Check `~/.config/i3/config`
- **Tmux**: Press `Prefix + ?` for help
- **Rofi**: Press `?` while in Rofi

### Custom Keybindings

To add your own:
- **Neovim**: Edit `init.lua` or create plugin configs
- **i3**: Edit `i3/.config/i3/config`
- **Tmux**: Edit `tmux/.config/tmux/tmux.conf`

---

**Last Updated**: 2025-11-25
