#!/bin/bash

# source https://github.com/sindresorhus/awesome/blob/main/.github/workflows/repo_linter.sh

# Find the repo in the git diff and then set it to an env variables.
REPO_TO_LINT=$(
	git diff origin/main -- README.md |
	# Look for changes (indicated by lines starting with +).
	grep ^+ |
	# Get the line that includes the README.
	grep -Eo 'https.*#README' |
	# Get just the URL.
	sed 's/#README//')

# If there's no repo found, exit quietly.
if [ -z ${REPO_TO_LINT+x} ]; then
	echo "No new link found in the format:  https://....#README"
else
	echo "Cloning $REPO_TO_LINT"
	mkdir cloned
	cd cloned
	git clone "$REPO_TO_LINT" .
	npx awesome-lint
fi
