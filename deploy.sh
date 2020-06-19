#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou

# The most disgusting build script I've seen in my life.
# See https://github.com/yesodweb/yesod/wiki/Deploying-Yesod-Apps-to-Heroku
# for more details.

# Paths
BINARY_PATH="dist*/build/*/ghc-*/xkcdbot-*/x/xkcdbot/build/xkcdbot/xkcdbot"
LIBRARY_DIR=/lib/x86_64-linux-gnu/
LIBRARIES="$LIBRARY_DIR/libffi.so.7 $LIBRARY_DIR/libm.so.6"

# Perform build
build ()
{
	cabal new-update
	cabal new-build
}

# Deploy to heroku
deploy ()
{
	# create temporary branch
	git checkout -b heroku

	# copy binary to pwd
	cp $BINARY_PATH ./worker

	# create Procfile
	echo -n "worker: ./worker" > Procfile

	# create dummy package.json
	echo '{ "name": "name", "version": "0.0.1", "dependencies": {} }' \
		> package.json

	# copy required libraries
	cp $LIBRARIES .

	# commit and push to heroku
	git add .
	git commit -m "heroku: deploy.sh"
	git push -f heroku heroku:master

	# return to master and delete temporary branch
	git checkout master
	git branch -D heroku
}

#build
deploy
