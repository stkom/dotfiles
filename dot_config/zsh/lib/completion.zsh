zmodload zsh/complist

zstyle ':completion:*'                  completer _oldlist _expand _complete _ignored _correct _approximate _files
zstyle ':completion:*'                  use-cache yes
zstyle ':completion:*'                  verbose true

# match uppercase from lowercase
zstyle ':completion:*'                  matcher-list 'm:{a-z}={A-Z}'

# provide .. as a completion
zstyle ':completion:*'                  special-dirs ..

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'     max-errors 'reply=($((($#PREFIX + $#SUFFIX) / 3)) numeric)'

# activate color-completion
zstyle ':completion:*:default'          list-colors ${(s.:.)LS_COLORS}

# separate matches into groups
zstyle ':completion:*'                  group-name ''
zstyle ':completion:*:matches'          group 'yes'

# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*'        insert-unambiguous true
zstyle ':completion:*:correct:*'        original true

# format on completion
zstyle ':completion:correct:'           prompt 'correct to: %e'
zstyle ':completion:*:corrections'      format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:descriptions'     format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
zstyle ':completion:*:messages'         format '%d'
zstyle ':completion:*:options'          auto-description '%d'
zstyle ':completion:*:options'          description 'yes'
zstyle ':completion:*:warnings'         format $'%{\e[0;31m%}no matches for:%{\e[0m%} %d'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*'         tag-order all-expansions
zstyle ':completion:*:history-words'    list false

# activate menu
zstyle ':completion:*:history-words'    menu yes

# on processes completion complete all user processes
zstyle ':completion:*:processes'        command 'ps -au $USER'

# provide more processes in completion of programs like killall
zstyle ':completion:*:processes-names'  command 'ps c -u $USER -o command | uniq'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*'  tag-order indexes parameters

# complete manual by their section
zstyle ':completion:*:man:*'            menu yes select
zstyle ':completion:*:manuals'          separate-sections true
zstyle ':completion:*:manuals.(^1*)'    insert-sections true

# ignore completion functions for commands you don't have
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
