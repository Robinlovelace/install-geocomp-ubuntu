#!/usr/bin/env bash
#===============================================================================
# install-general-purpose.sh
# General-purpose development and productivity tooling installer for Ubuntu
# Designed for pristine Ubuntu installations on wsp24.
#===============================================================================

set -euo pipefail

# ---- Color variables ----
RED='\033[0;31m'
GRN='\033[0;32m'
YEL='\033[1;33m'
BLU='\033[0;34m'
MAG='\033[0;35m'
CYN='\033[0;36m'
NC='\033[0m'

# ---- Output helpers ----
info()  { echo -e "${BLU}[INFO]${NC} $*"; }
ok()    { echo -e "${GRN}[OK]  ${NC} $*"; }
warn()  { echo -e "${YEL}[WARN]${NC} $*"; }
err()   { echo -e "${RED}[ERR] ${NC} $*"; exit 1; }
header(){ echo -e "\n${MAG}======================================================================${NC}\n${CYN}  $*\n${MAG}======================================================================${NC}"; }

# ---- Verify environment ----
[[ "$EUID" -ne 0 ]] || err "Please run this script as a standard user (not root/sudo directly). Sudo permissions will be requested where needed."

# ---- Initialize selections ----
INSTALL_SWAP=false
INSTALL_SHELL_UTILS=false
INSTALL_ZELLIJ=false
INSTALL_MODERN_DATA=false
INSTALL_DOCKER=false
INSTALL_NODE_JS=false
INSTALL_DESKTOP_PROD=false

# ---- Prompt wizard ----
header "General-Purpose Tooling Installer Setup Wizard"

echo -e "This interactive installer will help set up general-purpose development"
echo -e "and productivity tools on your pristine Ubuntu installation.\n"

read -rp "1. Increase Swap size to 16GB? (Recommended for memory stability) (y/N): " choice; [[ "$choice" =~ ^[Yy]$ ]] && INSTALL_SWAP=true
read -rp "2. Install core CLI and shell utilities (ripgrep, fd, bat)? (y/N): " choice; [[ "$choice" =~ ^[Yy]$ ]] && INSTALL_SHELL_UTILS=true
read -rp "3. Install Zellij terminal multiplexer (modern tmux)? (y/N): " choice; [[ "$choice" =~ ^[Yy]$ ]] && INSTALL_ZELLIJ=true
read -rp "4. Install Modern Data Stack (DuckDB + Pixi)? (y/N): " choice; [[ "$choice" =~ ^[Yy]$ ]] && INSTALL_MODERN_DATA=true
read -rp "5. Install Docker Engine and Compose? (y/N): " choice; [[ "$choice" =~ ^[Yy]$ ]] && INSTALL_DOCKER=true
read -rp "6. Install Node Version Manager (nvm), Node.js, Deno, and Claude Code? (y/N): " choice; [[ "$choice" =~ ^[Yy]$ ]] && INSTALL_NODE_JS=true
read -rp "7. Install desktop productivity tools (CopyQ, Flameshot, Guake)? (y/N): " choice; [[ "$choice" =~ ^[Yy]$ ]] && INSTALL_DESKTOP_PROD=true

echo -e "\n${GRN}Setup complete! Starting installation of selected components...${NC}"

# ==============================================================================
# SECTION 1: System Swap Configuration
# ==============================================================================
if [ "$INSTALL_SWAP" = true ]; then
    header "Configuring System Swap Space to 16GB"
    CURRENT_SWAP=$(swapon --show | wc -l)
    if [ "$CURRENT_SWAP" -gt 0 ]; then
        info "Temporarily turning off current swap..."
        sudo swapoff -a || true
    fi
    if [ -f /swap.img ]; then
        info "Removing existing swap.img..."
        sudo rm -f /swap.img
    fi
    info "Allocating 16GB swap file (this might take a brief moment)..."
    sudo fallocate -l 16G /swap.img || sudo dd if=/dev/zero of=/swap.img bs=1M count=16384 status=progress
    sudo chmod 600 /swap.img
    sudo mkswap /swap.img
    sudo swapon /swap.img
    
    # Ensure fstab entry exists
    if ! grep -q "/swap.img" /etc/fstab; then
        echo "/swap.img none swap sw 0 0" | sudo tee -a /etc/fstab
    fi
    ok "Swap expanded to 16GB successfully."
fi

# ==============================================================================
# SECTION 2: Standard CLI & Shell Utilities
# ==============================================================================
if [ "$INSTALL_SHELL_UTILS" = true ]; then
    header "Installing Core CLI & Shell Utilities"
    sudo apt update
    sudo apt install -y ripgrep fd-find bat curl wget build-essential git tmux htop

    # Configure batcat alias (Ubuntu names bat 'batcat' to avoid conflict)
    mkdir -p "$HOME/.local/bin"
    if [ ! -L "$HOME/.local/bin/bat" ] && [ -f /usr/bin/batcat ]; then
        ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"
        info "Created symlink for 'bat' command pointing to 'batcat'"
    fi
    
    # Add fd-find alias for find compatibility
    if [ ! -L "$HOME/.local/bin/fd" ] && [ -f /usr/bin/fdfind ]; then
        ln -sf /usr/bin/fdfind "$HOME/.local/bin/fd"
        info "Created symlink for 'fd' command pointing to 'fdfind'"
    fi
    
    ok "Core CLI utilities installed successfully."
fi

# ==============================================================================
# SECTION 3: Zellij Terminal Multiplexer
# ==============================================================================
if [ "$INSTALL_ZELLIJ" = true ]; then
    header "Installing Zellij Terminal Multiplexer"
    if command -v zellij &> /dev/null; then
        info "Zellij is already installed."
    else
        info "Downloading Zellij release..."
        TEMP_DIR=$(mktemp -d)
        trap 'rm -rf "$TEMP_DIR"' EXIT
        wget -q https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz -O "$TEMP_DIR/zellij.tar.gz"
        tar -xvf "$TEMP_DIR/zellij.tar.gz" -C "$TEMP_DIR"
        sudo mv "$TEMP_DIR/zellij" /usr/local/bin/
        ok "Zellij installed successfully to /usr/local/bin/zellij"
    fi
fi

# ==============================================================================
# SECTION 4: Modern Data Stack (DuckDB + Pixi)
# ==============================================================================
if [ "$INSTALL_MODERN_DATA" = true ]; then
    header "Installing DuckDB & Pixi Package Manager"
    
    # DuckDB Install
    if command -v duckdb &> /dev/null; then
        info "DuckDB is already installed."
    else
        info "Installing DuckDB..."
        curl -fsSL https://install.duckdb.org | sh
        ok "DuckDB installed successfully."
    fi

    # Pixi Package Manager Install
    if command -v pixi &> /dev/null; then
        info "Pixi is already installed."
    else
        info "Installing Pixi package manager..."
        curl -fsSL https://pixi.sh/install.sh | bash
        ok "Pixi installed successfully."
    fi
fi

# ==============================================================================
# SECTION 5: Docker Engine & Compose Setup
# ==============================================================================
if [ "$INSTALL_DOCKER" = true ]; then
    header "Installing Docker Engine & Compose"
    if command -v docker &> /dev/null; then
        info "Docker is already installed."
    else
        info "Setting up Docker official repository..."
        sudo apt update
        sudo apt install -y ca-certificates gnupg lsb-release
        sudo mkdir -p /etc/apt/keyrings
        sudo rm -f /etc/apt/keyrings/docker.gpg
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update
        info "Installing Docker packages..."
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
        
        info "Setting up Docker post-installation configurations..."
        sudo groupadd -f docker
        sudo usermod -aG docker "$USER"
        ok "Docker installed. Please log out and back in for user group changes to take effect."
    fi
fi

# ==============================================================================
# SECTION 6: Node.js, Deno, & Claude Code
# ==============================================================================
if [ "$INSTALL_NODE_JS" = true ]; then
    header "Installing Node.js (via NVM), Deno & Claude Code"
    
    # NVM and Node.js
    if [ -d "$HOME/.nvm" ]; then
        info "NVM is already installed."
    else
        info "Installing Node Version Manager (nvm)..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
        
        # Temporarily load nvm for this session
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        info "Installing Node.js LTS release..."
        nvm install --lts
        nvm use --lts
        ok "Node.js successfully installed."
    fi

    # Deno
    if command -v deno &> /dev/null; then
        info "Deno is already installed."
    else
        info "Installing Deno..."
        curl -fsSL https://deno.land/x/install/install.sh | sh
        ok "Deno successfully installed."
    fi

    # Claude Code
    info "Installing Claude Code command line tool..."
    # Ensure npm command is loaded
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    if command -v npm &> /dev/null; then
        npm install -g @anthropic-ai/claude-code || warn "Failed to install Claude Code globally. Please run 'npm install -g @anthropic-ai/claude-code' manually once shell is refreshed."
        ok "Claude Code installation triggered."
    else
        warn "npm not loaded in this shell. Re-run 'npm install -g @anthropic-ai/claude-code' in your active shell after reloading environment."
    fi
fi

# ==============================================================================
# SECTION 7: Desktop Productivity Tools
# ==============================================================================
if [ "$INSTALL_DESKTOP_PROD" = true ]; then
    header "Installing Desktop Productivity Tools (CopyQ, Flameshot, Guake)"
    sudo apt update
    sudo apt install -y copyq flameshot guake
    
    # Configure autostart folder if it doesn't exist
    mkdir -p "$HOME/.config/autostart"
    
    ok "Desktop productivity tools installed."
fi

# ==============================================================================
# Verification and Finish
# ==============================================================================
header "General-Purpose Installation Completed!"
echo -e "${GRN}Done! Your workstation is now loaded with modern development utilities.${NC}"
echo -e "${YEL}Please run the following commands to reload your environment and shell configuration:${NC}"
echo -e "  source ~/.bashrc"
echo -e "  # Or restart your active terminal session."
echo -e "  # (If you installed Docker, a system logout is required to activate docker permissions)."
echo -e "\n======================================================================"
