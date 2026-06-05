# =========================================================
# Plugins
# =========================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


zinit light zsh-users/zsh-completions

# zsh-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting

# auto suggestions
zinit light zsh-users/zsh-autosuggestions

#vi-mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

#tab-completions 
zinit light Aloxaf/fzf-tab


zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
