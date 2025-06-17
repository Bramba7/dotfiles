#!/bin/sh
# Smart installer for system-info script (POSIX compatible)
# Usage: curl -sSL https://raw.githubusercontent.com/Bramba7/dotfiles/main/scripts/install-system-info.sh | sh

REPO_URL="https://raw.githubusercontent.com/Bramba7/dotfiles/main/scripts/system-info.sh"
SCRIPT_PATH="/etc/profile.d/01-system-info.sh"

echo "🚀 Installing System Info Script..."

# Check if we need sudo (more robust check)
if [ "$(id -u)" -eq 0 ]; then
    # Running as root - no sudo needed
    SUDO=""
    echo "🔑 Running as root"
elif command -v sudo >/dev/null 2>&1; then
    # Not root but sudo available
    SUDO="sudo"
    echo "🔐 Using sudo for installation..."
else
    # Not root and no sudo - this will fail
    echo "Error: Not running as root and sudo not available"
    echo "Try: docker exec -u root <container> sh"
    exit 1
fi

# Download and install the script
if curl -sSL "$REPO_URL" | ${SUDO} tee "$SCRIPT_PATH" > /dev/null; then
    ${SUDO} chmod +x "$SCRIPT_PATH"
    echo "Script installed to $SCRIPT_PATH"
else
    echo "Failed to download script"
    exit 1
fi


# WSL compatibility - detect shell and add to appropriate profile
if grep -q "Microsoft\|WSL" /proc/version 2>/dev/null; then
    echo "🐧 WSL detected - adding to shell profiles..."
    
    # Detect current shell
    Current_shell=$(ps -p "$PPID" -o comm= | sed 's/^-//')
    
    case "$CURRENT_SHELL" in
        bash)
            if [ -f ~/.bashrc ]; then
                if ! grep -q "source $SCRIPT_PATH" ~/.bashrc; then
                    echo "source $SCRIPT_PATH" >> ~/.bashrc
                    echo "✅ Added to ~/.bashrc"
                fi
            fi
            ;;
        zsh)
            if [ -f ~/.zshrc ]; then
                if ! grep -q "source $SCRIPT_PATH" ~/.zshrc; then
                    echo "source $SCRIPT_PATH" >> ~/.zshrc
                    echo "✅ Added to ~/.zshrc"
                fi
            fi
            ;;
        fish)
            if [ -f ~/.config/fish/config.fish ]; then
                if ! grep -q "source $SCRIPT_PATH" ~/.config/fish/config.fish; then
                  echo "source $SCRIPT_PATH" >> ~/.config/fish/config.fish
                  echo "✅ Added to config.fish"
                fi
            fi
            ;;   
        *)
            echo "⚠️  Shell '$CURRENT_SHELL' detected - you may need to manually add:"
            echo "   source $SCRIPT_PATH"
            echo "   to your shell's profile file"
            ;;
    esac
    
    echo "💡 Current shell: $CURRENT_SHELL"
fi

echo ""
echo "🎉 Installation complete!"
echo "💡 Open a new terminal or run: source $SCRIPT_PATH"
echo ""

# Test the script
echo "📋 Testing script..."
source "$SCRIPT_PATH"
