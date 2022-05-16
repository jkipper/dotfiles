FROM registry.fedoraproject.org/fedora-toolbox:36
RUN dnf install -y git gcc g++ cmake make nodejs npm kitty neovim fish\
    fzf fd-find bat exa ripgrep git-delta  && \
    dnf copr enable -y cdayjr/yadm && dnf install -y yadm && dnf clean all
