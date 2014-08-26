#!/usr/bin/env bash

# Define basic colors as a starting point:
if [ "$(uname)" == "Darwin" ]; then
    source ./dotfiles/.bash_colors_Darwin
else
    source ./dotfiles/.bash_colors_Linux
fi

WARNINGMSG="\t${BIRed}!!!WARNING!!!${Color_Off}\n
This script is ${BIRed}DESTRUCTIVE!${Color_Off} It overwrites
all your previous (dotfile) setup.
Press ${Cyan}<Ctrl+C>${Color_Off} NOW to cancel..."

echo -e "${WARNINGMSG}"
read cancel

SETUPDIR=`pwd`
cd ${HOME}
if [ -d ./dotfiles/ ]; then
    mv -f dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
if [ -l .emacs.d ]; then
    rm .emacs.d
fi

rm -v ${HOME}/.screenrc
rm -v ${HOME}/.bash_profile
rm -v ${HOME}/.bashrc*
rm -v ${HOME}/.bash_colors

ln -sv	${SETUPDIR}/dotfiles/.screenrc		${HOME}/.screenrc
ln -sv	${SETUPDIR}/dotfiles/.bash_profile	${HOME}/.bash_profile
ln -sv	${SETUPDIR}/dotfiles/.bashrc		${HOME}/.bashrc
ln -sv	${SETUPDIR}/dotfiles/.bashrc_custom	${HOME}/.bashrc_custom
ln -sv	${SETUPDIR}/dotfiles/.emacs.d		${HOME}/.emacs.d

# Create color link:
if [ "$(uname)" == "Darwin" ]; then	# Mac
    ln -sv	${SETUPDIR}/dotfiles/.bash_colors_Darwin	${HOME}/.bash_colors
else
    ln -sv	${SETUPDIR}/dotfiles/.bash_colors_Linux		${HOME}/.bash_colors
fi


# GIT:
if [-d ${HOME}/.git.OLD/ ]; then
    rm -rfv ${HOME}/.git.OLD
fi
mkdir ${HOME}/.git.OLD

# move .gitignore:
mv -fv ${HOME}/.gitignore ${HOME}/.git.OLD/
ln -sv	${SETUPDIR}/dotfiles/.gitignore		${HOME}/.gitignore

# create .gitconfig:
mv -v ${HOME}/.gitconfig ${HOME}/.git.OLD/
GITCONFIG="[include]
\tpath = ${SETUPDIR}/dotfiles/.gitconfig"
echo -e "${GITCONFIG}" > ${HOME}/.gitconfig

# Create GIT user data:
GITUSER="[user]
\tname = \"\"
\temail = \"\"
[github]
\tuser = 
\ttoken = "
if [ ! -f ${HOME}/.gitconfig_user ]; then
    echo -e "${GITUSER}" > ${HOME}/.gitconfig_user
else
    echo -e ".gitconfig_user exists!\n"
fi

# Install NANO colors:
cd ${SETUPDIR}
if [ ! -d nanorc ]; then
    git clone https://github.com/nanorc/nanorc.git
fi
cd nanorc
make install
echo 'include ~/.nano/syntax/ALL.nanorc' >> ~/.nanorc
# rm -rf ${SETUPDIR}/nanorc


### Setup scripts:
if [ ! -d ${HOME}/bin ]; then
    echo "Creating directory: ${HOME}/bin/"
    mkdir ${HOME}/bin
fi

ln -si	${SETUPDIR}/scripts/gpp		${HOME}/bin/gpp		# GPP tool (C++)
ln -si	${SETUPDIR}/scripts/githubInit	${HOME}/bin/githubInit	# GitHub initializer
