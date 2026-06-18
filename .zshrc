# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  copybuffer
  copyfile
  git
  history
  kitchen
  knifectx
  kubetail
  repo
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# history
HISTFILE=~/.zsh_history
HISTSIZE=600000
SAVEHIST=600000
HIST_STAMPS="yyyy-mm-dd"

setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# aliases
alias history="history -i 1"
alias k="kubectl"
alias open="xdg-open"
alias sudo="sudo "
alias vim="nvim"

# secrets
[ -f "$HOME/.secret-file" ] && source "$HOME/.secret-file"

# PATH
export PATH=$HOME/.local/bin:$PATH

# version managers
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"

# kubectl completion
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
complete -o default -F __start_kubectl k

eval "$(goenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"
