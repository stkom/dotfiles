if [[ -e /usr/share/fzf ]]; then
  source '/usr/share/fzf/completion.zsh'
  source '/usr/share/fzf/key-bindings.zsh'
  export FZF_DEFAULT_COMMAND='fd ""'
fi
