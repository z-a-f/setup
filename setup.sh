

SETUPDIR=`pwd` 
cd ${HOME}
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi


rm -v ${HOME}/.screenrc
rm -v ${HOME}/.bash_profile
rm -v ${HOME}/.bashrc*
rm -v ${HOME}/.bash_colors

ln -sv 	${SETUPDIR}/dotfiles/.screenrc 		${HOME}/.screenrc
ln -sv 	${SETUPDIR}/dotfiles/.bash_colors 	${HOME}/.bash_colors
ln -sv 	${SETUPDIR}/dotfiles/.bash_profile 	${HOME}/.bash_profile
ln -sv 	${SETUPDIR}/dotfiles/.bashrc 		${HOME}/.bashrc
ln -sv 	${SETUPDIR}/dotfiles/.bashrc_custom 	${HOME}/.bashrc_custom
ln -svf	${SETUPDIR}/dotfiles/.emacs.d 		${HOME}/.emacs.d
