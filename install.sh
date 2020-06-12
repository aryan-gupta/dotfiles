#!/bin/bash
# set -x

REPO_DIR="${HOME}/Projects/scripts/nix/linux.files"

pushd "${REPO_DIR}/.config"

for D in *; do
	if [ -d "${D}" ]; then
		pushd "${HOME}/.config"
		ln -sf "${REPO_DIR}/.config/${D}" "${D}"
		popd
	fi
done