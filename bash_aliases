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
alias scp_vyos-1x='function _vyos_v1x() { \
    files=$(ls -1t ~/vyos-1x*.deb | head -n 4)
    scp -r $files $1:/tmp
    if [ "$?" == "0" ]; then
        ssh $1 sudo dpkg --install --force-all /tmp/vyos-1x*.deb
        ssh $1 sudo rm -f /tmp/vyos-1x*.deb
    fi
    }; _vyos_v1x'
alias func_vybld='function _func_vyos_build() { \
    docker pull vyos/vyos-build:$1
    docker run --rm -it \
        -v "$(pwd)":/vyos \
        -v "$HOME/.vimrc":/home/vyos_bld/.vimrc \
        -v "$HOME/.vim":/home/vyos_bld/.vim \
        -v "$HOME/.gitconfig":/etc/gitconfig \
        -v "$HOME/local.gitconfig":/etc/local.gitconfig \
        -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
        -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
        -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
        -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
        vyos/vyos-build:$1 bash
    }; _func_vyos_build'
alias vybld='func_vybld current'
alias vybld_equuleus='func_vybld equuleus'
alias vybld_crux='func_vybld crux'
alias isobuild='function _vyos_current() { \
    branch=$(jq -r -M '.vyos_branch' data/defaults.json)
    major="1.4"
    if [ $branch == "crux" ]; then
        major="1.2"
    elif [ $branch == "equuleus" ]; then
        major="1.3"
    fi
    version="${major}$1-$(date +%Y%m%d%H%M)"
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
    -v "$HOME/.bash_history":/home/ans_cvp/.bash_history \
    -v "$HOME/.bashrc":/home/ans_cvp/.bashrc \
    -w /arista \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    ansible-arista:latest bash'
