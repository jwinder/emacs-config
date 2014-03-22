# My Emacs Configuration

I use the emacs setup from [rubbish](https://github.com/rubbish/rubbish-emacs-setup) as a basis. I've added a few of my own opinionated things over the past couple years.

This configuration has been used for both Ubuntu & OSX. It should work fairly well right away.

# Getting Started w/ Ubuntu

Here are some helpful things for using this config with Ubuntu.

Some common packages (you might need others):

    apt-get install -y libgtk2.0-dev libXpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libncurses-dev markdown texinfo git subversion cvs rubygems rake
    gem install rake

Either download & install emacs:
* download [emacs 24.x](http://www.gnu.org/software/emacs/), `./configure`, `make`, `sudo make install`

Or use your package manager:

    sudo add-apt-repository ppa:cassou/emacs
    sudo apt-get update
    sudo apt-get install emacs24

And then:
* clone this repo to `$HOME/.emacs.d`
* run emacs

# Getting Started w/ OSX

Check out the OSX installation options on the [Emacs wiki](http://www.emacswiki.org/emacs/EmacsForMacOS).

I prefer [homebrew](https://github.com/Homebrew/homebrew).

And then:
* clone this repo to `$HOME/.emacs.d`
* run emacs
