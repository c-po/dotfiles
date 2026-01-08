alias dbld='dpkg-buildpackage -uc -us -tc -b'
alias dir='ls --color=auto --format=vertical'
alias grep='grep --color=auto --exclude=*.pyc --exclude-dir=\.git --exclude-dir=\.svn'
alias irssi='TERM=screen-256color irssi'
alias l='ls -al --color=always'
alias la='ls -A'
alias ll='ls -l'
alias lsports='sudo netstat -tulnp'
alias v1x='scp_vyos-1x LR1.wue3.mybll.net'
alias v2x='scp_vyos-1x LR2.wue3.mybll.net'
alias v3x='scp_vyos-1x LR3.wue3.mybll.net'
alias v4x='scp_vyos-1x LR4.wue3.mybll.net'
alias ssh-weak="ssh -o KexAlgorithms=+diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-rsa"
alias scp_vyos-1x='function _vyos_v1x() { \
    files=$(ls -t ~/vyos-1x_*.deb ~/vyos-1x-smoketest_*.deb | head -n 2)
    scp -r $files $1:/tmp
    if [ "$?" == "0" ]; then
        ssh $1 sudo dpkg --install --force-all /tmp/*.deb
        ssh $1 sudo rm -f /tmp/*.deb
    fi
    }; _vyos_v1x'
alias func_vybld='function _func_vyos_build() { \
    CONTAINER=docker
    if test -x /usr/bin/podman; then
        CONTAINER=/usr/bin/podman
    fi
#   docker pull vyos/vyos-build:$1
    $CONTAINER run --rm -it \
        -v "$(pwd)":/vyos \
        -v "$HOME/.vimrc":/home/vyos_bld/.vimrc \
        -v "$HOME/.vim":/home/vyos_bld/.vim \
        -v "$HOME/.gitconfig":/home/vyos_bld/.gitconfig \
        -v "$HOME/local.gitconfig":/home/vyos_bld/local.gitconfig \
        -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
        -v "$HOME/local.bash_aliases":/home/vyos_bld/local.bash_aliases \
        -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
        -v "$HOME/.bash_history":/home/vyos_bld/.bash_history \
        -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
        -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
        vyos/vyos-build:$1 bash
    }; _func_vyos_build'
alias vybld='func_vybld current'
alias vybld_sagitta='func_vybld sagitta'
alias vybld_circinus='func_vybld circinus'
alias isobuild='function _vyos_current() { \
    branch=$(tomlq -r -M .vyos_branch data/defaults.toml)
    major="1.5"
    build_type="development"
    version_extra=""
    if [ ! -z "$1" ]; then
        version_extra=$1
    fi
    flavor="generic"
    if [ ! -z "$2" ]; then
        flavor=$2
    fi
    if [ ${branch} == "sagitta" ]; then
        version="1.4$-$(date +%Y%m%d%H%M)"
        build_type="release"
    elif [ ${branch} == "circinus" ]; then
        version="1.5$1-$(date +%Y%m%d%H%M)"
    else
        version="$(date -u +%Y.%m.%d-%H%M)$1"
    fi
    custom_packages="strace vim tmux git mc vyos-1x-smoketest"
    echo "Building custom VyOS version: $version"
    sudo ./build-vyos-image \
        --build-by christian@breunig.cc \
        --version $version \
        --architecture amd64 \
        --build-type $build_type \
        --custom-package "$custom_packages" $flavor; }; _vyos_current'
alias vydoc='docker pull vyos/vyos-documentation && docker run --rm -it \
    -v "$(pwd)":/vyos \
    -w /vyos/docs \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-documentation make html'
alias youtube='./yt-dlp_linux -f bestvideo*+bestaudio/best'
alias youtube_audio='~/yt-dlp_linux -f "bestaudio[ext=m4a]/bestaudio"'
alias anscvp='podman run --rm --interactive --tty \
    --security-opt label=disable \
    --volume "$HOME:$HOME" \
    --userns=keep-id \
    --workdir $HOME \
    ansible-arista:latest bash'
alias kali='docker run --rm -it \
    -v "$(pwd)":/kali \
    -w /kali \
    kalilinux/kali-rolling'
alias shimbld='docker run --rm -it \
        -v "$(pwd)":/vyos \
        -v /etc/timezone:/etc/timezone:ro \
        -v /etc/localtime:/etc/localtime:ro \
        -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
        debian:trixie-20250630 bash'
