export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# =========================================================
# Shell behaviour
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# =========================================================
# Smart directory navigation & lf
# =========================================================
LF_ICONS=$(cat ~/.config/lf/ICONS | tr '\n' ':')
export LF_ICONS

# Initialize zoxide
eval "$(zoxide init --cmd cd zsh)"

# =========================================================
# Modular Config Files
# =========================================================
# Prompt/theme
source "$ZDOTDIR/prompt.zsh"


# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"


# fzf configuration
source "$ZDOTDIR/fzf.zsh"


# =========================================================
# Completion
# =========================================================
# Load completion system
autoload -Uz compinit && compinit 
zinit cdreplay -q
# Enable interactive completion menu selection
zstyle ':completion:*' menu no

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'




# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"


source /usr/share/nvm/init-nvm.sh
