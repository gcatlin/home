[![Build Status](https://secure.travis-ci.org/justone/dfm.png?branch=master)](http://travis-ci.org/justone/dfm/)

# dfm - a utility to manage dotfiles

## Overview

dfm is a small utility that manages dotfiles.  It:

* makes it easy to install (and uninstall) your dotfiles on new servers
* easys fetching and merging changes that were pushed from other machines
* simplifies working with your dotfiles repository, no matter where your current directory is

## Using dfm

dfm works best when it's included in your dotfiles repository.  If you don't
have a dotfiles repository already, you can use [this starter
repository](https://github.com/justone/dotfiles).

## Install

```
curl -sL https://raw.github.com/gcatlin/home/master/install.sh | bash
```

## Update dfm

```
dfm remote add upstream git://github.com/justone/dotfiles.git   # only need to do this once
dfm checkout master
dfm fetch upstream
dfm merge upstream/master
```

## Full documentation
For more information, check out the [wiki](http://github.com/justone/dotfiles/wiki).

You can also run <tt>dfm \--help</tt>.
