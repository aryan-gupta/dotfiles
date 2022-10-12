#!/bin/bash
set -x

REPO_DIR="${HOME}/Projects/scripts/nix/linux.files"

# install gitdetails
pushd "${HOME}" >> /dev/null
ln -s "${REPO_DIR}/.gitconfig" ".gitconfig"
ln -s "${REPO_DIR}/.gitconfig-${HOST}" ".gitconfig-local"

# install and overwrite .zshrc and .bashrc
rm "${HOME}/.zshrc"
ln -s "${REPO_DIR}/.zshrc" "${HOME}/.zshrc"
rm "${HOME}/.bashrc"
ln -s "${REPO_DIR}/.bashrc" "${HOME}/.bashrc"


pushd "${REPO_DIR}/.config"  >> /dev/null

# save the old .config folder
cp -r "${HOME}/.config" "/tmp/.config-bak"
mv    "${HOME}/.config" "${HOME}/.config-bak"

# create ln of the dotfiles
ln -s "${REPO_DIR}/.config"   "${HOME}/.config"

# move old .config items back
mv    "${HOME}/.config-bak/*" "${HOME}/.config/"

# remove old .config folder
rm -r "${HOME}/.config-bak"
