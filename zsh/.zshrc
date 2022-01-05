
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRLT_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="--preview 'exa {} | head -200'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || bat {} || exa {}) 2> /dev/null | head -200'"
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen load spaceship-prompt/spaceship-prompt spaceship
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/fzf 

  zgen oh-my-zsh plugins/docker
  zgen load Aloxaf/fzf-tab
  zgen oh-my-zsh plugins/git

  zgen oh-my-zsh plugins/sudo 
  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen oh-my-zsh plugins/history-substring-search
  # generate the init script from plugins above
  zgen save
fi
neofetch
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview '(bat $realpath || exa $realpath) 2> /dev/null | head -200'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
