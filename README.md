# Dotfiles

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

You can also run <tt>dfm --help</tt>.

