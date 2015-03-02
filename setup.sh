#!/usr/bin/env bash

##################################################################
# Define basic colors as a starting point:
if [ "$(uname)" == "Darwin" ]; then
    source ./dotfiles/bash_colors_Darwin
else
    source ./dotfiles/bash_colors_Linux
fi

##################################################################
# Show Warning:
WARNINGMSG="\t${BIRed}!!!WARNING!!!${Color_Off}\n
This script is ${BIRed}DESTRUCTIVE!${Color_Off} It overwrites
all your previous (dotfile) setup.
Press ${Cyan}<Ctrl+C>${Color_Off} NOW to cancel..."

INFO="\n${BIGreen}*INFO*,${Color_Off}"
WARN="${BIYellow}*WARN*,${Color_Off}"

echo -e "${WARNINGMSG}"
read cancel

##################################################################
# Setup Links:
SETUPDIR=`pwd`
cd ${HOME}
echo -e "${INFO} Removing the old dotfiles"
if [ -d ./dotfiles/ ]; then
    mv -f dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi

rm -v ${HOME}/.emacs.d
rm -v ${HOME}/.screenrc
rm -v ${HOME}/.bash_profile
rm -v ${HOME}/.bashrc*
rm -v ${HOME}/.bash_colors

echo -e "${INFO} Creating soft links"
ln -sfv	${SETUPDIR}/dotfiles/screenrc		${HOME}/.screenrc
ln -sfv	${SETUPDIR}/dotfiles/bash_profile	${HOME}/.bash_profile
ln -sfv	${SETUPDIR}/dotfiles/bashrc		${HOME}/.bashrc
ln -sfv	${SETUPDIR}/dotfiles/bashrc_custom	${HOME}/.bashrc_custom


# ln -svf `which pygmentize-2.7`			${HOME}/bin/pygmentize  # Python highlighter

# Create basic MUTT setup if it doesn't exist:
if [ ! -f ${HOME}/.muttrc ]; then
    echo -e "${INFO} Creating basic MUTTRC"
    echo -e "${WARN} Please, modify it!"
    ln -sv ${SETUPDIR}/dotfiles/muttrc		${HOME}/.muttrc
fi

##################################################################
# Create color link:
if [ "$(uname)" == "Darwin" ]; then	# Mac
    ln -sfv	${SETUPDIR}/dotfiles/bash_colors_Darwin	${HOME}/.bash_colors
else
    ln -sfv	${SETUPDIR}/dotfiles/bash_colors_Linux	${HOME}/.bash_colors
fi

##################################################################
# GIT:
echo -e "${INFO} Setting up GIT"
if [ -d ${HOME}/.git.OLD/ ]; then
    rm -rfv ${HOME}/.git.OLD
fi
mkdir ${HOME}/.git.OLD

# move .gitignore:
mv -fv 	${HOME}/.gitignore 			${HOME}/.git.OLD/
ln -sv	${SETUPDIR}/dotfiles/gitignore		${HOME}/.gitignore

# create .gitconfig:
mv -v ${HOME}/.gitconfig ${HOME}/.git.OLD/
GITCONFIG="[include]
\tpath = ${SETUPDIR}/dotfiles/gitconfig"
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
    echo -e ".gitconfig_user exists!\n" # Don't everwrite the USER info - might have tokens

fi

##################################################################
# Setup Emacs:
ln -sfv	${SETUPDIR}/dotfiles/emacs.d		${HOME}/.emacs.d
git clone git://github.com/hvesalai/sbt-mode.git ${HOME}/.emacs.d/.elisp/sbt-mode

##################################################################
# Setup NANO:
rm -v ${HOME}/.nanorc
# Install NANO colors:
echo -e "${INFO} Setting up NANO"
cd ${SETUPDIR}
if [ ! -d nanorc ]; then
    git clone https://github.com/nanorc/nanorc.git
fi
cd nanorc
make install
echo 'include ~/.nano/syntax/ALL.nanorc' > ~/.nanorc
# rm -rf ${SETUPDIR}/nanorc


##################################################################
# Setup scripts:
echo -e "${INFO} Setting up scripts"
if [ ! -d ${HOME}/bin ]; then
    echo -e "${WARN} ${HOME}/bin not found"
    echo "Creating directory: ${HOME}/bin/"
    mkdir ${HOME}/bin
fi

##################################################################
# Setup COLORGCC:
echo -e "${INFO} Setting up COLORGCC"
echo -e "${WARN} Please, check ${HOME}/.colorgccrc"
echo -e "${WARN} if the paths to compilers are set!"
ln -svf ${SETUPDIR}/dotfiles/colorgccrc ${HOME}/.colorgccrc
ln -svf ${SETUPDIR}/scripts/colorgcc ${HOME}/bin/colorgcc
ln -svf ${HOME}/bin/colorgcc ${HOME}/bin/color-g++
ln -svf ${HOME}/bin/colorgcc ${HOME}/bin/color-gcc
ln -svf ${HOME}/bin/colorgcc ${HOME}/bin/color-c++
ln -svf ${HOME}/bin/colorgcc ${HOME}/bin/color-cc


ln -svf	${SETUPDIR}/scripts/gpp		${HOME}/bin/gpp		# GPP tool (C++)
ln -svf	${SETUPDIR}/scripts/githubInit	${HOME}/bin/githubInit	# GitHub initializer
ln -svf ${SETUPDIR}/scripts/repo	${HOME}/bin/repo	# Android GIT wrapper
ln -svf ${SETUPDIR}/scripts/fixGitPermissions	${HOME}/bin/fixGitPermissions

##################################################################
# Emacs pacakges
pushd .
cd ${SETUPDIR}/dotfiles/emacs.d/.elisp/
# (Need to setup MELPA :( )
rm -rfv go-mode.el && git clone git@github.com:zafartahirov/go-mode.el.git
popd
