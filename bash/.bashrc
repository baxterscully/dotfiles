#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# Tab completion settings
bind "set menu-complete-display-prefix on"
bind "set show-all-if-ambiguous on"
bind "set show-all-if-unmodified on"
bind "set completion-ignore-case on"
bind "set visible-stats on"
bind "set colored-stats on"
bind "set colored-completion-prefix on"

# Tab cycles through completions
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'  # Shift+Tab cycles backward

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'

# PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bax/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bax/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/bax/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/bax/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

fastfetch

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#313244,label:#CDD6F4 \
  --border=rounded --height=50% --layout=reverse \
  --margin=1 \
  --padding=1 \
  --info=inline-right \
  --prompt='❯ ' \
  --pointer='▶' \
  --no-scrollbar \
"

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
