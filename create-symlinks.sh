#!/bin/sh
dotdir=$(pwd)

create()
{
	if [ -f $2 ] || [ -d $2 ]; then
		echo "Skipping $2 ... already present"
	else
		ln -s $dotdir/$1 $2
		echo "Created symlink $dotdir/$1 -> $2"
	fi
}

create bashrc ~/.bashrc
create gitconfig ~/.gitconfig
create vim ~/.vim
create vimrc ~/.vimrc
create selected_editor ~/.selected_editor
create tmux.conf ~/.tmux.conf
create tigrc ~/.tigrc
create bash_profile ~/.bash_profile
create gitexcludes ~/.gitexcludes
create bash_aliases ~/.bash_aliases
create nanorc ~/.nanorc
create inputrc ~/.inputrc

if [ ! -f ~/local.bash_aliases ]; then
    touch ~/local.bash_aliases
fi

if [ ! -f ~/local.gitconfig ]; then
	echo "# local only configuration which may differ from machine to machine
[user]
    name = Christian Poessinger
    email = christian@poessinger.com

[http]
    # for communication with www repositories accessible via proxy
    # you need to define a proxy (probably also for http)
    # proxy = http://user:password@proxy.domain.tld:80

    # stop verifying SSL for self signed certificates (only if
    # really required! Think about the consequences
    # sslVerify = false
	" > ~/local.gitconfig

	echo "Created ~/local.gitconfig"
fi
