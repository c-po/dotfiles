# Remove packages not in this Brewfile: brew bundle cleanup --force [--global]
# Install packages in this Brewfile: brew bundle install [--global]
#
# Options
cask_args appdir: '/Applications', require_sha: true

tap 'lance0/tap'

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
cask 'font-hack-nerd-font'
cask 'zed'                # Multiplayer code editor

# DevOps
brew 'ansible'            # Automation
cask 'docker-desktop'     # Containers

# Network and Security Testing
brew 'bettercap'          # Network, scanning and monitoring
brew 'nmap'               # Port scanning
brew 'mtr'                # Better traceroute tool
brew 'lance0/tap/ttl'     # Better mtr
brew 'wget'
brew 'curl'
brew 'bgpq3'
brew 'ncftp'
brew 'watch'

##################################
# Desktop Applications           #
##################################

cask 'gimp'               # Photo editor - Photoshop replacement

# Media
cask 'spotify', args: { require_sha: false } # Propietary music streaming
cask 'vlc'                # Media player

# Personal Applications
mas 'enpass', id: 732710998
mas 'slack', id: 803453959
cask 'nextcloud'
mas 'Menu Bar Controller für Sonos', id: 6749351423
mas 'Amphetamine', id: 937984704
cask 'wireshark-app'

# Browsers
cask 'firefox'
cask 'google-chrome', args: { require_sha: false }
