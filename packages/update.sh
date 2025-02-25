#!/bin/bash

brew list > ./brew-formulae.txt
brew list --cask > ./brew-casks.txt
code --list-extensions > ./vscode-extensions.txt

echo "Packages updated!"
