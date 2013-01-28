# my .emacs.d

Inappropriately closely inspired by [rubbish](https://github.com/rubbish/rubbish-emacs-setup).

Here are a few common packages that you might need (you might need others):

    apt-get install libgtk2.0-dev
    apt-get install libXpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev
    apt-get install libncurses-dev
    apt-get install texinfo git subversion cvs
    apt-get install rubygems rake
    gem install rake

or, this works also (After adding the repo)

    sudo add-apt-repository ppa:cassou/emacs
    sudo apt-get update
    sudo apt-get install emacs-snapshot

* for json-validate, install [trentm json](https://github.com/trentm/json)
* for markdown install with the following `apt-get install markdown`

Then, pull down the repo and link it to emacs.

    git clone git@github.com:adamdecaf/emacs.d.git $HOME/.emacs.d

# Problems

If you have issues with rinari, this should fix it.

     git clone git://github.com/eschulte/rinari.git
     cd rinari
     git submodule init
     git submodule update

Notes for myself of things to install

    el-get-install haskell-mode
    apt-get install erlang-mode
    el-get-install erlang-mode
    el-get-install ruby-mode
    el-get-install php-mode
