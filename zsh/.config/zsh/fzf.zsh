# --------------------------------------------------
# FZF
# --------------------------------------------------

source <(fzf --zsh)

# Use fd everywhere
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Better previews
export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always --line-range=:500 {}'
"

# Catppuccin Mocha theme
export FZF_DEFAULT_OPTS="
  --height=80%
  --layout=reverse
  --border=rounded
  --margin=1
  --padding=1
  --info=inline-right
  --prompt='󰍉 '
  --pointer='▶'
  --marker='✓'
  --separator='─'
  --scrollbar='│'
  --preview-window='right:60%:border-left'
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-u:preview-half-page-up'
  --bind='ctrl-d:preview-half-page-down'
  --bind='alt-j:down'
  --bind='alt-k:up'
  --color=bg+:#313244
  --color=bg:#1e1e2e
  --color=spinner:#f5e0dc
  --color=hl:#f38ba8
  --color=fg:#cdd6f4
  --color=header:#f38ba8
  --color=info:#cba6f7
  --color=pointer:#f5e0dc
  --color=marker:#a6e3a1
  --color=fg+:#cdd6f4
  --color=prompt:#cba6f7
  --color=hl+:#f38ba8
  --preview='
    if [[ -d {} ]]; then
      eza --tree --level=2 --icons --color=always {}
    else
      bat --style=numbers --color=always --line-range=:500 {}
    fi
  '
"

export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

export FZF_ALT_C_OPTS="
  --preview 'eza --tree --level=3 --icons --color=always {}'
"
