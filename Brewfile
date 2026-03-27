# Remove packages not in this Brewfile: brew bundle cleanup --force [--global]
# Install packages in this Brewfile: brew bundle install [--global]
#
# Options
cask_args appdir: '/Applications', require_sha: true

tap "lance0/tap"

##################################
# Command Line                   #
##################################

brew 'bash'
brew 'bash-completion'

brew 'mas'                # MacAppStore cli interface

brew 'git'                # Version controll
brew 'tig'                # Text-mode interface for git
brew 'neovim'             # Text editor
brew 'tmux'               # Terminal multiplexer
brew 'screen'             # Terminal multiplexer
brew 'minicom'            # Serial Console Tool
brew 'htop'               # Process Monitor
brew 'ipcalc'             # IP address calculator
brew 'ipv6calc'           # IPv6 subnet calculator
brew 'midnight-commander' # Norton Commander file/directory browser

brew 'dos2unix'           # Change line endings

##################################
# Development                    #
##################################

# Development Apps
cask 'iterm2'             # Better terminal emulator
cask 'visual-studio-code' # Code editor - IDE
cask "font-hack-nerd-font"

# DevOps
brew 'ansible'            # Automation
brew 'docker'             # Containers

# Network and Security Testing
brew 'bettercap'          # Network, scanning and monitoring
brew 'nmap'               # Port scanning
brew 'mtr'                # Better traceroute tool
brew 'wget'
brew 'curl'

##################################
# Desktop Applications           #
##################################

cask 'gimp'               # Photo editor - Photoshop replacement

# Media
cask 'spotify', args: { require_sha: false } # Propietary music streaming
cask 'vlc'                # Media player

# Personal Applications
cask 'enpass'             # Password Manager

# Browsers
cask 'firefox'
