#!/bin/bash
set -euo pipefail

# =============================================================================
# One-shot developer Mac setup
# Run: /bin/bash -c "$(curl -fsSL <raw-github-url>)" or just: bash colleague-setup.sh
# =============================================================================

echo "=== Developer Mac Setup ==="
echo ""

# -----------------------------------------------------------------------------
# Xcode (optional)
# -----------------------------------------------------------------------------
read -p "Install full Xcode from Mac App Store? (y/N) " -n 1 -r
echo ""
INSTALL_XCODE=${REPLY,,}

# -----------------------------------------------------------------------------
# Xcode Command Line Tools (required by Homebrew)
# -----------------------------------------------------------------------------
if ! xcode-select -p &>/dev/null; then
  echo ">>> Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "    Press any key after the installation completes."
  read -n 1 -s -r
fi

# -----------------------------------------------------------------------------
# Homebrew
# -----------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
  echo ">>> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for Apple Silicon
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo ">>> Updating Homebrew..."
brew update

# -----------------------------------------------------------------------------
# Taps
# -----------------------------------------------------------------------------
echo ">>> Adding taps..."
brew tap jandedobbeleer/oh-my-posh

# -----------------------------------------------------------------------------
# CLI tools
# -----------------------------------------------------------------------------
echo ">>> Installing CLI tools..."

# Shell & terminal
brew install tmux
brew install lsd                    # ls alternative
brew install fd                     # find alternative
brew install ripgrep                # grep alternative
brew install fzf                    # fuzzy finder
brew install delta                  # git diff pager
brew install direnv                 # per-directory env
brew install jandedobbeleer/oh-my-posh/oh-my-posh  # shell prompt

# Git
brew install git
brew install gh                     # GitHub CLI
brew install lazygit                # Git TUI
brew install gitleaks               # secret scanning
brew install git-credential-manager # credential storage

# .NET
brew install dotnet@8
brew install dotnet@9
brew install dotnet                 # latest (10)

# Node.js
brew install fnm                    # Fast Node Manager

# Python (for LSP / scripting)
brew install python3

# Cloud & infrastructure
brew install azure-cli
brew install azure-functions-core-tools
brew install bicep

# Azure CLI extensions
echo ">>> Installing Azure CLI extensions..."
az extension add --name azure-devops --yes 2>/dev/null || true
az extension add --name resource-graph --yes 2>/dev/null || true
az extension add --name application-insights --yes 2>/dev/null || true

# Database
brew install sqlcmd

# Documents & diagrams
brew install pandoc
brew install basictex               # LaTeX for pandoc PDF
brew install mermaid-cli            # mmdc - diagram generation

# Build & code tools
brew install tree-sitter
brew install imagemagick
brew install powershell/tap/powershell
brew install pnpm
brew install nixfmt

# Utilities
brew install zip
brew install mas                    # Mac App Store CLI
brew install tmuxinator

# API testing
brew install bruno-cli

# LSP servers (for editor integration)
brew install lua-language-server
brew install bash-language-server
brew install yaml-language-server
brew install marksman               # Markdown LSP
brew install typescript-language-server

# NOTE: nil (Nix LSP), basedpyright, fsautocomplete, omnisharp are best
# installed via their own ecosystems (nix, pip, dotnet tool) if needed.

# -----------------------------------------------------------------------------
# Cask applications
# -----------------------------------------------------------------------------
echo ">>> Installing applications..."
brew install --cask visual-studio-code
brew install --cask jetbrains-rider
brew install --cask ghostty
brew install --cask brave-browser
brew install --cask rancher
brew install --cask bruno

# -----------------------------------------------------------------------------
# Fonts
# -----------------------------------------------------------------------------
echo ">>> Installing fonts..."
brew install --cask font-meslo-lg-nerd-font
brew install --cask font-fira-code-nerd-font

# -----------------------------------------------------------------------------
# VS Code extensions
# -----------------------------------------------------------------------------
if command -v code &>/dev/null; then
  echo ">>> Installing VS Code extensions..."

  # .NET
  code --install-extension ms-dotnettools.vscode-dotnet-runtime
  code --install-extension ms-dotnettools.csharp
  code --install-extension ms-dotnettools.csdevkit

  # Languages
  code --install-extension ionide.ionide-fsharp
  code --install-extension jnoortheen.nix-ide
  code --install-extension ms-vscode.powershell

  # OpenAPI
  code --install-extension 42crunch.vscode-openapi
  code --install-extension redhat.vscode-yaml

  # Tools & visualization
  code --install-extension hediet.vscode-drawio
  code --install-extension chrischinchilla.vscode-pandoc
  code --install-extension bierner.markdown-mermaid
else
  echo "    VS Code not found in PATH. Open it once, run"
  echo "    'Shell Command: Install code command in PATH' from the"
  echo "    command palette, then rerun this section."
fi

# -----------------------------------------------------------------------------
# Xcode (full, from Mac App Store)
# -----------------------------------------------------------------------------
if [[ "$INSTALL_XCODE" == "y" ]]; then
  echo ">>> Installing Xcode from Mac App Store (this takes a while)..."
  mas install 497799835
  echo "    Open Xcode once to accept the license and install components."
fi

# -----------------------------------------------------------------------------
# Shell setup (zsh)
# -----------------------------------------------------------------------------
echo ">>> Configuring shell..."

# fzf key bindings
if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc
fi

# direnv hook
if ! grep -q 'direnv hook zsh' ~/.zshrc 2>/dev/null; then
  echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
fi

# fnm hook
if ! grep -q 'fnm env' ~/.zshrc 2>/dev/null; then
  echo 'eval "$(fnm env --use-on-cd --shell zsh)"' >> ~/.zshrc
fi

# oh-my-posh
if ! grep -q 'oh-my-posh init' ~/.zshrc 2>/dev/null; then
  echo 'eval "$(oh-my-posh init zsh)"' >> ~/.zshrc
fi

# Rancher Desktop path
if ! grep -q '.rd/bin' ~/.zshrc 2>/dev/null; then
  echo 'export PATH="$HOME/.rd/bin:$PATH"' >> ~/.zshrc
fi

# Useful aliases
if ! grep -q 'alias dir=' ~/.zshrc 2>/dev/null; then
  cat >> ~/.zshrc << 'ALIASES'

# Aliases
alias dir="ls -al"
alias sudo="sudo "
ALIASES
fi

# -----------------------------------------------------------------------------
# macOS defaults
# -----------------------------------------------------------------------------
echo ">>> Setting macOS defaults..."

# Finder: show all files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: sort folders first
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder: search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Don't write .DS_Store on network or USB
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Screenshots: save to ~/Documents/Screenshots as PNG
mkdir -p ~/Documents/Screenshots
defaults write com.apple.screencapture location -string "$HOME/Documents/Screenshots"
defaults write com.apple.screencapture type -string "png"

# Restart Finder to apply
killall Finder 2>/dev/null || true

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal (or: source ~/.zshrc)"
echo "  2. Set Ghostty font to 'MesloLGM Nerd Font Mono' in config"
echo "  3. Sign into GitHub CLI: gh auth login"
echo "  4. Sign into Azure CLI: az login"
echo "  5. Install a Node version: fnm install --lts"
echo "  6. Open Rancher Desktop and enable dockerd/containerd"
if [[ "$INSTALL_XCODE" == "y" ]]; then
  echo "  7. Open Xcode to accept license and install components"
fi
