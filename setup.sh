#!/bin/bash

pushd ./dotfiles || exit
stow --restow --target ~/ *
popd || exit

