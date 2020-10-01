#!/bin/bash

pushd ./dotfiles
stow --stow --target ~/ *
popd

