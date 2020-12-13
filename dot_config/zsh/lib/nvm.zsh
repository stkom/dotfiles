NVM_SOURCE='/usr/share/nvm'

if [[ -e $NVM_SOURCE ]]; then
  export NVM_SOURCE
  export NVM_DIR="$HOME/.local/share/nvm"
  source "$NVM_SOURCE/nvm.sh" --no-use
  source "$NVM_SOURCE/bash_completion"
  source "$NVM_SOURCE/install-nvm-exec"
fi
