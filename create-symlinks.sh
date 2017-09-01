#!/bin/sh
dotdir=$(pwd)

create()
{
	if [ -f $2 ] || [ -d $2 ]; then
		echo "Skipping $2 ... already present"
	else
		ln -s $dotdir/$1 $2
		echo "created symlink $dotdir/$1 -> $2"
	fi
}

create bashrc ~/.bashrc
create gitconfig ~/.gitconfig
create irssi ~/.irssi
create vimrc ~/.vimrc
