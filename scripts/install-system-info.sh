#!/bin/bash
# Smart installer for system-info script
# Usage: curl -sSL https://raw.githubusercontent.com/Bramba7/dotfiles/main/scripts/install-system-info.sh | bash

REPO_URL="https://raw.githubusercontent.com/Bramba7/dotfiles/main/scripts/system-info.sh"
SCRIPT_PATH="/etc/profile.d/01-system-info.sh"

echo "🚀 Installing System Info Script..."

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    # Running as root - no sudo needed
    SUDO=""
else
    # Not root - use sudo
    SUDO="sudo"
    echo "🔐 Root access required for installation..."
fi

# Download and install the script
if curl -sSL "$REPO_URL" | $SUDO tee "$SCRIPT_PATH" > /dev/null; then
    $SUDO chmod +x "$SCRIPT_PATH"
    echo "✅ Script installed to $SCRIPT_PATH"
else
    echo "❌ Failed to download script"
    exit 1
fi

# WSL compatibility
if grep -q "Microsoft" /proc/version 2>/dev/null || grep -q "WSL" /proc/version 2>/dev/null; then
    echo "🐧 WSL detected - adding to shell profiles..."
    
    # Add to bashrc if it exists
    if [ -f ~/.bashrc ]; then
        if ! grep -q "source $SCRIPT_PATH" ~/.bashrc; then
            echo "source $SCRIPT_PATH" >> ~/.bashrc
            echo "✅ Added to ~/.bashrc"
        fi
    fi
    
    # Add to zshrc if it exists
    if [ -f ~/.zshrc ]; then
        if ! grep -q "source $SCRIPT_PATH" ~/.zshrc; then
            echo "source $SCRIPT_PATH" >> ~/.zshrc
            echo "✅ Added to ~/.zshrc"
        fi
    fi
fi

echo ""
echo "🎉 Installation complete!"
echo "💡 Open a new terminal or run: source $SCRIPT_PATH"
echo ""

# Test the script
echo "📋 Testing script..."
source "$SCRIPT_PATH"
