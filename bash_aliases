alias dbld='dpkg-buildpackage -uc -us -tc -b'
alias dir='ls --color=auto --format=vertical'
alias grep='grep --color=auto --exclude=*.pyc --exclude-dir=\.git --exclude-dir=\.svn'
alias irssi='TERM=screen-256color irssi'
alias l='ls -al --color=always'
alias la='ls -A'
alias ll='ls -l'
alias lsports='sudo netstat -tulnp'
alias vybld='docker pull vyos/vyos-build:current && docker run --rm -it \
    -v "$(pwd)":/vyos \
    -v "$HOME/.vimrc":/home/vyos_bld/vimrc \
    -v "$HOME/.gitconfig":/etc/gitconfig \
    -v "$HOME/local.gitconfig":/etc/local.gitconfig \
    -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
    -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
    -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-build:current bash'
alias vybld_crux='docker pull vyos/vyos-build:crux && docker run --rm -it \
    -v "$(pwd)":/vyos \
    -v "$HOME/.gitconfig":/etc/gitconfig \
    -v "$HOME/local.gitconfig":/etc/local.gitconfig \
    -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
    -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
    -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-build:crux bash'
alias isobuild='function _vyos_current() { \
    version="1.3$1-$(date '+%Y%m%d%H%M')"
    echo "Building custom VyOS version: $version"
    ./configure --build-by christian@poessinger.com \
    --version $version \
    --build-type release \
    --custom-package "mc vim git tmux grc vyos-1x-smoketest" && sudo make iso; }; _vyos_current'
alias vydoc='docker pull vyos/vyos-documentation && docker run --rm -it \
    -v "$(pwd)":/vyos \
    -w /vyos/docs \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-documentation make html'
alias youtube='~/youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio"'
alias anscvp='docker run --rm -it \
    -v "$(pwd)":/arista \
    -v "$HOME/.vimrc":/home/ans_cvp/.vimrc \
    -v "$HOME/.vim":/home/ans_cvp/.vim \
    -v "$HOME/.gitconfig":/etc/gitconfig \
    -v "$HOME/local.gitconfig":/etc/local.gitconfig \
    -v "$HOME/.bash_aliases":/home/ans_cvp/.bash_aliases \
    -v "$HOME/.bashrc":/home/ans_cvp/.bashrc \
    -w /arista \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    ansible-arista:latest bash'
