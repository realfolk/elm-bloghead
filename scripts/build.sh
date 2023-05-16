#! /usr/bin/env bash

# Run this script from the root of the repository.

BUILD_DIR=.build
SRC_DIR=src

# Clean the build directory.
test -d $BUILD_DIR && rm -rf $BUILD_DIR

# Make the build directory, which should be ignored by git.
mkdir -p $BUILD_DIR

# Compile our Elm program to JavaScript.
elm make --debug --output=$BUILD_DIR/app.js $SRC_DIR/Main.elm

# Copy our HTML file to the build folder.
cp $SRC_DIR/index.html $BUILD_DIR/index.html
