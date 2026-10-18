if ((${+terminfo[smkx]})) && ((${+terminfo[rmkx]})); then
  function zle-line-init() { echoti smkx }
  function zle-line-finish() { echoti rmkx }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

typeset -A key
key=(
Home      "${terminfo[khome]}"
End       "${terminfo[kend]}"
Insert    "${terminfo[kich1]}"
Delete    "${terminfo[kdch1]}"
Up        "${terminfo[kcuu1]}"
Down      "${terminfo[kcud1]}"
Left      "${terminfo[kcub1]}"
Right     "${terminfo[kcuf1]}"
PageUp    "${terminfo[kpp]}"
PageDown  "${terminfo[knp]}"
BackTab   "${terminfo[kcbt]}"
)

autoload -Uz edit-command-line
zle -N edit-command-line

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

typeset -A abbreviations
abbreviations=(
'C'   '| wc -l'
'H'   '| head'
'Hl'  "--help | $PAGER"
'N'   '&> /dev/null'
'Ne'  '2> /dev/null'
'No'  '> /dev/null'
'P'   "| $PAGER"
'S'   '| sort'
'T'   '| tail'
'V'   '|& vim -'
'X'   '| xargs'
)

function abbrev-expand() {
  emulate -L zsh
  setopt extended_glob
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}
zle -N abbrev-expand

function help-show-abbrev() {
  zle -M "$(print "Available abbreviations for expansion:"; print -a -C 2 ${(kv)abbreviations})"
}
zle -N help-show-abbrev

function sudo-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  if [[ $BUFFER != sudo\ * ]]; then
    BUFFER="sudo $BUFFER"
    CURSOR=$((CURSOR + 5))
  fi
}
zle -N sudo-command-line

function jump-after-first-word() {
  local words
  words=(${(z)BUFFER})
  if ((${#words} <= 1)) ; then
    CURSOR=${#BUFFER}
  else
    CURSOR=${#${words[1]}}
  fi
}
zle -N jump-after-first-word

function bind2maps() {
  local map sequence widget
  local -a maps

  while [[ $1 != '--' ]]; do
    maps+=("$1")
    shift
  done
  shift

  if [[ $1 == '-s' ]]; then
    shift
    sequence="$1"
  else
    sequence="${key[$1]}"
  fi

  [[ -z "$sequence" ]] && return 1
  widget="$2"

  for map in "${maps[@]}"; do
    bindkey -M "$map" "$sequence" "$widget"
  done
}

bindkey -v
bind2maps emacs             -- Home     beginning-of-somewhere
bind2maps       viins vicmd -- Home     vi-beginning-of-line
bind2maps emacs             -- End      end-of-somewhere
bind2maps       viins vicmd -- End      vi-end-of-line
bind2maps emacs viins       -- Insert   overwrite-mode
bind2maps             vicmd -- Insert   vi-insert
bind2maps emacs             -- Delete   delete-char
bind2maps       viins vicmd -- Delete   vi-delete-char
bind2maps emacs viins vicmd -- Up       up-line-or-search
bind2maps emacs viins vicmd -- Down     down-line-or-search
bind2maps emacs             -- Left     backward-char
bind2maps       viins vicmd -- Left     vi-backward-char
bind2maps emacs             -- Right    forward-char
bind2maps       viins vicmd -- Right    vi-forward-char
bind2maps emacs viins       -- PageUp   history-beginning-search-backward-end
bind2maps emacs viins       -- PageDown history-beginning-search-forward-end

bind2maps emacs viins       -- -s '^x.' abbrev-expand
bind2maps emacs viins       -- -s '^x,' help-show-abbrev

bind2maps       viins       -- -s '^?'  backward-delete-char
bind2maps       viins       -- -s '^h'  backward-delete-char
bind2maps emacs viins       -- -s '\ee' edit-command-line
bind2maps emacs viins       -- -s '^x1' jump-after-first-word
bind2maps emacs viins       -- -s '^u'  kill-whole-line
bind2maps emacs viins       -- -s ' '   magic-space
bind2maps emacs viins       -- -s '\ei' menu-complete
bind2maps emacs viins       -- -s '^xp' push-line-or-edit
bind2maps emacs viins       -- -s '^os' sudo-command-line

bind2maps menuselect        -- BackTab  reverse-menu-complete
bind2maps menuselect        -- -s 'h'   vi-backward-char
bind2maps menuselect        -- -s 'j'   vi-down-line-or-history
bind2maps menuselect        -- -s 'k'   vi-up-line-or-history
bind2maps menuselect        -- -s 'l'   vi-forward-char
