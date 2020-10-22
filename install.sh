#!/bin/bash
set -x

REPO_DIR="${HOME}/Projects/scripts/nix/linux.files"

pushd "${REPO_DIR}/.config"  >> /dev/null

for D in *; do
	if [ -d "${D}" ]; then
		pushd "${HOME}/.config" >> /dev/null
		if [ -d "${D}" ]; then
			ln -s "${REPO_DIR}/.config/${D}" "${D}"
		fi
		popd >> /dev/null
	fi
done