alias dbld='dpkg-buildpackage -uc -us -tc -b'
alias dir='ls --color=auto --format=vertical'
alias grep='grep --color=auto --exclude=*.pyc --exclude-dir=\.git --exclude-dir=\.svn'
alias irssi='TERM=screen-256color irssi'
alias l='ls -al --color=always'
alias la='ls -A'
alias ll='ls -l'
alias vybld='docker run --rm -it \
    -v "$(pwd)":/vyos \
    -v "$HOME/.gitconfig":/etc/gitconfig \
    -v "$HOME/local.gitconfig":/etc/local.gitconfig \
    -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
    -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
    -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-build:current bash'
alias vybld_crux='docker run --rm -it \
    -v "$(pwd)":/vyos \
    -v "$HOME/.gitconfig":/etc/gitconfig \
    -v "$HOME/local.gitconfig":/etc/local.gitconfig \
    -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
    -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
    -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-build:crux bash'
alias isobuild='./configure --build-by christian@poessinger.com \
    --debian-mirror http://ftp.de.debian.org/debian/ \
    --version 1.2-rolling-$(date '+%Y%m%d%H%M')-wifi \
    --build-type release \
    && sudo make iso'
alias vydoc='docker run --rm -it \
    -v "$(pwd)":/vyos \
    -w /vyos/docs \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-documentation:master make html'
