#!/usr/bin/env bash

if [[ ! -e $HOME/.config/zsh/zgen ]]; then
  git clone https://github.com/tarjoilija/zgen.git "$HOME/.config/zsh/zgen"
fi
