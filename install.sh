#!/bin/bash
set -x

REPO_DIR="${HOME}/Projects/scripts/nix/linux.files"

# install gitdetails
ln -s "${REPO_DIR}/.gitconfig" "${HOME}/.gitconfig"
ln -s "${REPO_DIR}/.gitconfig-${HOST}" "${HOME}/.gitconfig-local"

# install and overwrite .zshrc and .bashrc
rm "${HOME}/.zshrc"
ln -s "${REPO_DIR}/.zshrc" "${HOME}/.zshrc"
rm "${HOME}/.bashrc"
ln -s "${REPO_DIR}/.bashrc" "${HOME}/.bashrc"

# save the old .config folder
cp -r "${HOME}/.config" "/tmp/.config-bak"
mv    "${HOME}/.config" "${HOME}/.config-bak"

# create ln of the dotfiles
ln -s "${REPO_DIR}/.config"   "${HOME}/.config"

# move old .config items back
mv    "${HOME}/.config-bak/*" "${HOME}/.config/"

# remove old .config folder
rm -r "${HOME}/.config-bak"

# install alacritty machine specific options
ln -s "${HOME}/.config/alacritty/alacritty-${HOST}.yml" "${HOME}/.config/alacritty/alacritty-local.yml"
