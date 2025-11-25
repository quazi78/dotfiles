#!/bin/bash

# Dotfiles Installation Script
# Installs dotfiles using GNU Stow with automatic dependency management

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
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

# Detect OS and package manager
detect_os() {
    if [ -f /etc/arch-release ]; then
        OS="arch"
        PKG_MANAGER="pacman"
        INSTALL_CMD="sudo pacman -S --noconfirm"
    elif [ -f /etc/debian_version ]; then
        OS="debian"
        PKG_MANAGER="apt"
        INSTALL_CMD="sudo apt-get install -y"
    elif [ -f /etc/fedora-release ]; then
        OS="fedora"
        PKG_MANAGER="dnf"
        INSTALL_CMD="sudo dnf install -y"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        PKG_MANAGER="brew"
        INSTALL_CMD="brew install"
    else
        OS="unknown"
        PKG_MANAGER="unknown"
    fi
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install GNU Stow
install_stow() {
    if command_exists stow; then
        print_success "GNU Stow is already installed"
        return 0
    fi

    print_header "Installing GNU Stow"
    
    case $PKG_MANAGER in
        pacman)
            sudo pacman -S --noconfirm stow
            ;;
        apt)
            sudo apt-get update
            sudo apt-get install -y stow
            ;;
        dnf)
            sudo dnf install -y stow
            ;;
        brew)
            brew install stow
            ;;
        *)
            print_error "Unable to install stow automatically. Please install it manually."
            exit 1
            ;;
    esac
    
    print_success "GNU Stow installed successfully"
}

# Backup existing configs
backup_configs() {
    print_header "Backing up existing configurations"
    
    BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    local configs=("nvim" "tmux" "ghostty" "bat" "fish" "omp" "git" "ripgrep" "yazi")
    local backed_up=0
    
    for config in "${configs[@]}"; do
        if [ -e "$HOME/.config/$config" ] && [ ! -L "$HOME/.config/$config" ]; then
            mv "$HOME/.config/$config" "$BACKUP_DIR/"
            print_info "Backed up: $config"
            backed_up=$((backed_up + 1))
        fi
    done
    

    
    if [ $backed_up -gt 0 ]; then
        print_success "Backed up $backed_up configuration(s) to: $BACKUP_DIR"
    else
        print_info "No existing configurations to backup"
        rmdir "$BACKUP_DIR" 2>/dev/null || true
    fi
}

# Install dependencies
install_dependencies() {
    print_header "Installing dependencies"
    
    if [ "$OS" = "unknown" ]; then
        print_warning "Unknown OS. Skipping automatic dependency installation."
        print_info "Please install dependencies manually. See README.md for details."
        return 0
    fi
    
    print_info "Detected OS: $OS"
    print_info "Package manager: $PKG_MANAGER"
    
    # Ask user if they want to install dependencies
    read -p "Install dependencies? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Skipping dependency installation"
        return 0
    fi
    
    case $PKG_MANAGER in
        pacman)
            print_info "Installing core dependencies..."
            $INSTALL_CMD neovim tmux fish git ripgrep fd bat fzf zoxide git-delta yazi
            
            read -p "Install Ghostty terminal? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                if command_exists yay; then
                    yay -S --noconfirm ghostty
                elif command_exists paru; then
                    paru -S --noconfirm ghostty
                else
                    $INSTALL_CMD ghostty || print_warning "Ghostty not found in pacman. It is likely in the AUR (e.g. ghostty-git). Please install manually with an AUR helper."
                fi
            fi
            
            read -p "Install Neovim dependencies (Node.js, Python)? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                $INSTALL_CMD nodejs npm python python-pip tree-sitter gcc
            fi
            ;;
        apt)
            print_info "Updating package list..."
            sudo apt-get update
            print_info "Installing core dependencies..."
            # Note: yazi and git-delta might not be in default repos for all versions
            $INSTALL_CMD neovim tmux fish git ripgrep fd-find bat fzf zoxide
            
            # Try to install delta and yazi if available
            $INSTALL_CMD git-delta yazi || print_warning "git-delta or yazi not found in repos. Install manually (e.g. via cargo)."
            
            read -p "Install Ghostty terminal? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                # Ghostty might need manual install on some distros, but let's try
                $INSTALL_CMD ghostty || print_warning "Ghostty not found in repos. Please install manually."
            fi
            
            read -p "Install Neovim dependencies (Node.js, Python)? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                $INSTALL_CMD nodejs npm python3 python3-pip build-essential
            fi
            ;;
        brew)
            print_info "Installing core dependencies..."
            $INSTALL_CMD neovim tmux fish git ripgrep fd bat fzf zoxide git-delta yazi
            
            read -p "Install Ghostty terminal? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                $INSTALL_CMD ghostty
            fi
            
            read -p "Install Neovim dependencies (Node.js, Python)? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                $INSTALL_CMD node python3
            fi
            ;;
        *)
            print_warning "Automatic dependency installation not supported for $PKG_MANAGER"
            ;;
    esac
    
    print_success "Dependencies installed"
}

# Stow configurations
stow_configs() {
    print_header "Installing dotfiles with GNU Stow"
    
    # Get list of stowable directories (those with .config subdirectory or config files)
    local packages=()
    for dir in */; do
        dir=${dir%/}  # Remove trailing slash
        # Skip hidden directories and docs
        if [[ ! "$dir" =~ ^\. ]] && [ "$dir" != "docs" ] && [ "$dir" != "scripts" ]; then
            packages+=("$dir")
        fi
    done
    
    print_info "Available packages: ${packages[*]}"
    
    read -p "Install all packages? (Y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        # Interactive selection
        print_info "Select packages to install (space-separated, or 'all'):"
        for i in "${!packages[@]}"; do
            echo "  $((i+1)). ${packages[$i]}"
        done
        read -p "Enter numbers or package names: " selection
        
        if [ "$selection" = "all" ]; then
            # Install all
            :
        else
            # Parse selection
            local selected=()
            for item in $selection; do
                if [[ "$item" =~ ^[0-9]+$ ]]; then
                    # Number selection
                    idx=$((item - 1))
                    if [ $idx -ge 0 ] && [ $idx -lt ${#packages[@]} ]; then
                        selected+=("${packages[$idx]}")
                    fi
                else
                    # Name selection
                    if [[ " ${packages[@]} " =~ " ${item} " ]]; then
                        selected+=("$item")
                    fi
                fi
            done
            packages=("${selected[@]}")
        fi
    fi
    
    # Stow each package
    for package in "${packages[@]}"; do
        print_info "Stowing: $package"
        if stow -t "$HOME" -v "$package" 2>&1 | grep -q "CONFLICT"; then
            print_warning "Conflict detected for $package. Use -D to delete existing symlinks first."
            read -p "  Restow $package? This will override existing symlinks (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                stow -t "$HOME" -R "$package"
                print_success "Restowed: $package"
            else
                print_warning "Skipped: $package"
            fi
        else
            stow -t "$HOME" "$package"
            print_success "Stowed: $package"
        fi
    done
}

# Install Neovim plugins
install_nvim_plugins() {
    if ! command_exists nvim; then
        print_warning "Neovim not found. Skipping plugin installation."
        return 0
    fi
    
    print_header "Installing Neovim plugins"
    
    print_info "This will install all plugins via lazy.nvim..."
    nvim --headless "+Lazy! sync" +qa
    
    print_success "Neovim plugins installed"
}



# Main installation flow
main() {
    echo -e "${BLUE}"
    cat << "EOF"
    ____        __  _____ __         
   / __ \____  / /_/ __(_) /__  _____
  / / / / __ \/ __/ /_/ / / _ \/ ___/
 / /_/ / /_/ / /_/ __/ / /  __(__  ) 
/_____/\____/\__/_/ /_/_/\___/____/  
                                      
EOF
    echo -e "${NC}"
    
    print_header "Dotfiles Installation"
    print_info "This script will install your dotfiles using GNU Stow"
    echo
    
    # Detect OS
    detect_os
    
    # Check if we're in the dotfiles directory
    if [ ! -f "README.md" ] || [ ! -d "nvim" ]; then
        print_error "Please run this script from the dotfiles directory"
        exit 1
    fi
    
    # Install stow first
    install_stow
    
    # Backup existing configs
    backup_configs
    
    # Install dependencies
    install_dependencies
    
    # Stow configurations
    stow_configs
    

    
    # Install Neovim plugins
    install_nvim_plugins
    
    # Final message
    echo
    print_header "Installation Complete!"
    print_success "Your dotfiles have been installed"
    echo
    print_info "Next steps:"
    print_info "  1. Restart your terminal"
    print_info "  2. Set Fish as default shell: chsh -s \$(which fish)"
    print_info "  3. Install a Nerd Font for proper icon display"
    print_info "  4. Check README.md for additional configuration"
    echo
    print_info "Enjoy your new setup! 🚀"
}

# Run main function
main
