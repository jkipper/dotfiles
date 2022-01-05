source "${HOME}/.zgen/zgen.zsh"
# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh themes/sorin
  zgen oh-my-zsh plugins/fzf 

  zgen oh-my-zsh plugins/docker

  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/history-substring-search
  zgen load Aloxaf/fzf-tab

  zgen oh-my-zsh plugins/sudo 
  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  # generate the init script from plugins above
  zgen save
fi
neofetch
