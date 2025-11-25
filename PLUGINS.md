# 📦 Neovim Plugins

Complete reference for all installed Neovim plugins, their purpose, and configuration.

## Plugin Manager

### lazy.nvim
**Repository**: [folke/lazy.nvim](https://github.com/folke/lazy.nvim)  
**Purpose**: Modern plugin manager with lazy loading and automatic updates  
**Config**: `nvim/.config/nvim/lua/config/lazy.lua`

**Features**:
- Automatic plugin installation on first launch
- Lazy loading for faster startup
- Built-in update checker
- Lock file for reproducible installs

**Commands**:
- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy update` - Update plugins
- `:Lazy clean` - Remove unused plugins

---

## Colorschemes

### Kanagawa (Active)
**Repository**: [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)  
**Config**: `nvim/.config/nvim/lua/plugins/kanagawa.lua`

Warm, Japanese-inspired colorscheme based on the famous painting "The Great Wave off Kanagawa".

### Catppuccin
**Repository**: [catppuccin/nvim](https://github.com/catppuccin/nvim)  
**Config**: `nvim/.config/nvim/lua/plugins/catppuccin.lua`

Soothing pastel theme with four flavors: Latte, Frappé, Macchiato, and Mocha.

### Darkfox
**Repository**: [EdenEast/nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)  
**Config**: `nvim/.config/nvim/lua/plugins/darkfox.lua`

Dark, high-contrast theme from the Nightfox collection.

**Switching themes**: Edit `init.lua` line 23:
```lua
vim.cmd.colorscheme "kanagawa"  -- Change to catppuccin or darkfox
```

---

## File Navigation

### Neo-tree
**Repository**: [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)  
**Config**: `nvim/.config/nvim/lua/plugins/neo-tree.lua`

Modern file explorer with git integration.

**Key Bindings**:
- `Ctrl + n` - Toggle file tree (left sidebar)
- `Space + bf` - Show buffers in floating window

**Features**:
- Shows hidden files by default
- Git status indicators
- Hides `.git`, `.DS_Store`, `thumbs.db`
- Respects `.gitignore`

**In Neo-tree**:
- `a` - Add file/directory
- `d` - Delete
- `r` - Rename
- `c` - Copy
- `x` - Cut
- `p` - Paste
- `R` - Refresh

### Telescope
**Repository**: [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)  
**Config**: `nvim/.config/nvim/lua/plugins/telescope.lua`

Fuzzy finder for files, grep, and more.

**Key Bindings**:
- `Ctrl + p` - Find files
- `Space + fg` - Live grep (search in files)

**Dependencies**: ripgrep, fd

**In Telescope**:
- `Ctrl + j/k` - Navigate results
- `Enter` - Open file
- `Ctrl + x` - Open in horizontal split
- `Ctrl + v` - Open in vertical split
- `Esc` - Close

---

## UI Enhancements

### Lualine
**Repository**: [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)  
**Config**: `nvim/.config/nvim/lua/plugins/lualine.lua`

Beautiful statusline with buffer tabs.

**Features**:
- Shows open buffers in statusline
- Integration with Noice.nvim for command display
- Minimal separators for clean look
- Auto-updates with mode changes

### Which-key
**Repository**: [folke/which-key.nvim](https://github.com/folke/which-key.nvim)  
**Config**: `nvim/.config/nvim/lua/plugins/which-key.lua`

Displays available keybindings in a popup.

**Key Bindings**:
- `Space + ?` - Show buffer-local keymaps

**Usage**: Start typing a key sequence and pause - which-key will show available completions.

### Mini Icons
**Repository**: [echasnovski/mini.icons](https://github.com/echasnovski/mini.nvim)  
**Config**: `nvim/.config/nvim/lua/plugins/mini-icons.lua`

Provides file type icons for Neo-tree and other plugins.

### Colorizer
**Repository**: [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)  
**Config**: `nvim/.config/nvim/lua/plugins/colorizer.lua`

Highlights color codes with their actual colors (e.g., `#FF0000` appears in red).

---

## Code Intelligence

### Treesitter
**Repository**: [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)  
**Config**: `nvim/.config/nvim/lua/plugins/treesitter.lua`

Advanced syntax highlighting and code understanding.

**Features**:
- Accurate syntax highlighting
- Code folding
- Incremental selection
- Better indentation

**Installed parsers**: Auto-installs on first use per language

**Commands**:
- `:TSInstall <language>` - Install parser for a language
- `:TSUpdate` - Update all parsers

---

## Git Integration

### Git Stuff
**Config**: `nvim/.config/nvim/lua/plugins/git-stuff.lua`

Git integration plugins (gitsigns, fugitive, or similar).

**Features**:
- Git status in sign column
- Inline blame
- Hunk navigation
- Stage/unstage hunks

---

## Navigation

### Tmux Navigator
**Repository**: [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)  
**Config**: `nvim/.config/nvim/lua/plugins/tmux-navigator.lua`

Seamless navigation between Neovim and tmux panes.

**Key Bindings**:
- `Ctrl + h` - Move left
- `Ctrl + j` - Move down
- `Ctrl + k` - Move up
- `Ctrl + l` - Move right
- `Ctrl + \` - Move to previous pane

**Note**: Works both in Neovim and tmux - the same keys navigate both!

---

## Adding New Plugins

1. Create a new file in `nvim/.config/nvim/lua/plugins/`:
   ```lua
   -- nvim/.config/nvim/lua/plugins/myplugin.lua
   return {
     'author/plugin-name',
     dependencies = {
       'required/plugin',
     },
     config = function()
       require('plugin-name').setup({
         -- configuration here
       })
     end
   }
   ```

2. Restart Neovim or run `:Lazy sync`

3. The plugin will be automatically installed and loaded

## Plugin Update Workflow

```bash
# Open Neovim
nvim

# Inside Neovim
:Lazy sync        # Install/update/clean all plugins
:Lazy update      # Update only
:Lazy clean       # Remove unused plugins
:Lazy profile     # See startup time per plugin
```

## Troubleshooting

### Plugin not loading
```vim
:Lazy reload <plugin-name>
```

### Clear plugin cache
```bash
rm -rf ~/.local/share/nvim/lazy
nvim  # Plugins will reinstall
```

### Check plugin status
```vim
:Lazy
```
Look for errors (red) or warnings (yellow).

### Update all parsers
```vim
:TSUpdate
```

---

**Last Updated**: 2025-11-25
