

export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRLT_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="--preview 'exa --color=always {} | head -200'"
export FZF_CTRL_T_OPTS="--preview '(bat --color=always --decorations=never {} || exa --color=always {}) 2> /dev/null | head -200'"
source "${HOME}/.zgenom/zgenom.zsh"

# if the init script doesn't exist
if ! zgenom saved; then

  # specify plugins here
  zgenom load spaceship-prompt/spaceship-prompt spaceship
  zgenom oh-my-zsh
  zgenom oh-my-zsh plugins/fzf 

  zgenom oh-my-zsh plugins/docker
  zgenom load Aloxaf/fzf-tab
  zgenom oh-my-zsh plugins/git

  zgenom oh-my-zsh plugins/sudo 
  zgenom load zsh-users/zsh-completions
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom oh-my-zsh plugins/history-substring-search
  # generate the init script from plugins above
  zgenom save
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:(cd|rm|ls|bat):*' fzf-preview '(bat --color=always --decorations=never $realpath || exa --color=always $realpath) 2> /dev/null | head -200'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
enable-fzf-tab


# Load pyenv automatically by appending
# the following to
# ~/.zprofile (for login shells)
# and ~/.zshrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


typeset -Ug path cdpath fpath manpath
