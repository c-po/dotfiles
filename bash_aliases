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
    PATTERN_BASE="vyos-1x"
    files=$(ls -1t ~/${PATTERN_BASE}*.deb | head -n 4)
    scp -r $files $1:/tmp
    if [ "$?" == "0" ]; then
        ssh $1 sudo dpkg --install --force-all /tmp/${PATTERN_BASE}*.deb
        ssh $1 sudo rm -f /tmp/${PATTERN_BASE}*.deb
    fi
    }; _vyos_v1x'
alias func_vybld='function _func_vyos_build() { \
#   docker pull vyos/vyos-build:$1
    docker run --rm -it \
        -v "$(pwd)":/vyos \
        -v /etc/timezone:/etc/timezone:ro \
        -v /etc/localtime:/etc/localtime:ro \
        -v "$HOME/.vimrc":/home/vyos_bld/.vimrc \
        -v "$HOME/.vim":/home/vyos_bld/.vim \
        -v "$HOME/.gitconfig":/home/vyos_bld/.gitconfig \
        -v "$HOME/local.gitconfig":/home/vyos_bld/local.gitconfig \
        -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
        -v "$HOME/local.bash_aliases":/home/vyos_bld/local.bash_aliases \
        -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
        -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
        -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
        vyos/vyos-build:$1 bash
    }; _func_vyos_build'
alias vybld='func_vybld current'
alias vybld_sagitta='func_vybld sagitta'
alias vybld_equuleus='func_vybld equuleus'
alias vybld_crux='func_vybld crux'
alias isobuild='function _vyos_current() { \
    branch=$(tomlq -r -M .vyos_branch data/defaults.toml)
    major="1.5"
    flavor="generic"
    if [ ${branch} == "sagitta" ]; then
        major="1.4"
        flavor="iso"
    fi
    custom_packages="strace vim tmux git mc vyos-1x-smoketest"
    version="${major}$1-$(date +%Y%m%d%H%M)"
    echo "Building custom VyOS version: $version"
    sudo ./build-vyos-image \
        --build-by christian@breunig.cc \
        --version $version \
        --build-type release \
        --architecture amd64 \
        --custom-package "$custom_packages" $flavor; }; _vyos_current'
alias isobuild_equuleus='function _vyos_current() { \
    branch=$(jq -r -M .vyos_branch data/defaults.json)
    major="1.3"
    custom_packages="mc vim git tmux vyos-1x-smoketest"
    if [ $branch == "crux" ]; then
        major="1.2"
        custom_packages="mc vim git tmux"
    fi
    version="${major}$1-$(date +%Y%m%d%H%M)"
    echo "Building custom VyOS version: $version"
    ./configure --build-by christian@breunig.cc \
        --version $version --build-type release --custom-package "$custom_packages"
    sudo make iso; }; _vyos_current'
alias vydoc='docker pull vyos/vyos-documentation && docker run --rm -it \
    -v "$(pwd)":/vyos \
    -w /vyos/docs \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    vyos/vyos-documentation make html'
alias youtube='./yt-dlp_linux -f bestvideo*+bestaudio/best'
alias youtube_audio='~/yt-dlp_linux -f "bestaudio[ext=m4a]/bestaudio"'
alias anscvp='docker run --rm -it \
    -v "$(pwd)":/arista \
    -v /etc/timezone:/etc/timezone:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v "$HOME/.vimrc":/home/ans_cvp/.vimrc \
    -v "$HOME/.vim":/home/ans_cvp/.vim \
    -v "$HOME/.gitconfig":/etc/gitconfig \
    -v "$HOME/local.gitconfig":/etc/local.gitconfig \
    -v "$HOME/local.bash_aliases":/home/ans_cvp/local.bash_aliases \
    -v "$HOME/.bash_aliases":/home/ans_cvp/.bash_aliases \
    -v "$HOME/.bash_history":/home/ans_cvp/.bash_history \
    -v "$HOME/.bashrc":/home/ans_cvp/.bashrc \
    -w /arista \
    -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
    ansible-arista:latest bash'
