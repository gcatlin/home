#!/usr/bin/env bash

function command_exists () { hash "$1" 2>&- ; }

if command_exists git ; then
	git clone https://github.com/gcatlin/home.git ~/.home &&
	~/.home/bin/dfm &&
	mkdir -p ~/.vim/tmp &&
	mkdir -p ~/.vim/bundle/vundle &&
	git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle &&
	vim -c ':BundleInstall' -c ':qa!'
else
	mkdir ~/.home &&
	curl -skL https://github.com/gcatlin/home/tarball/master | tar -zx --strip 1 -C ~/.home &&
	~/.home/bin/dfm &&
	mkdir -p ~/.vim/tmp &&
	mkdir -p ~/.vim/bundle/vundle &&
	curl -skL https://github.com/gmarik/vundle/tarball/master | tar -zx --strip 1 -C ~/.vim/bundle/vundle &&
	vim -c ':BundleInstall' -c ':qa!'
fi

. ~/.bashrc


