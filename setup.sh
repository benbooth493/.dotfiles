#!/bin/bash

pushd ./dotfiles
stow --restow --target ~/ *
popd
