
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi

ln -s dotfiles/.screenrc .
ln -s dotfiles/.bash_profile .
ln -s dotfiles/.bashrc .
ln -s dotfiles/.bashrc_custom .
ln -s dotfiles/.bash_colors .
ln -sf dotfiles/.emacs.d .
