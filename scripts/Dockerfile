ARG BASE
FROM $BASE
RUN add-apt-repository ppa:neovim-ppa/unstable && apt-get update && apt-get install --no-install-recommends -y \
    neovim \
    zsh \
    fd-find \
    bat \
    fzf \
    build-essential && \
    ln -s /usr/bin/batcat /usr/bin/bat && \
    ln -s /usr/bin/fdfind /usr/bin/fd

RUN git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom" && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install && \
    git clone https://github.com/jkipper/dotfiles.git ~/dotfiles && \
    mkdir -p /root/.config && \
    ln -s ~/dotfiles/nvim ~/.config/nvim && \
    mkdir -p /root/completions && \
    wget https://raw.githubusercontent.com/ninja-build/ninja/master/misc/zsh-completion --output-document=/root/completions/_ninja-completion && \
    wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb --output-document=/tmp/ripgrep.deb && \
    dpkg -i /tmp/ripgrep.deb

RUN mkdir -p ~/commandhistory \
    && echo 'fpath+="~/completions"' > ~/.zshrc && \
    echo "HISTSIZE=1000" >> ~/.zshrc && \
    echo "SAVEHIST=1000" >> ~/.zshrc && \
    echo "HISTFILE=~/.zsh_history" >> ~/.zshrc && \
    echo "source ~/dotfiles/zsh/.zshrc" >> ~/.zshrc &&\
    zsh -c "source ~/.zshrc" && \
    chsh -s /bin/zsh

ARG GIT_USER
ARG GIT_MAIL
RUN git config --global user.name "$GIT_USER" && git config --global user.email "$GIT_MAIL" && git config --global credential.helper "store --file=/run/secrets/git_credentials"
