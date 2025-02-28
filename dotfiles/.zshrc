typeset -U path cdpath fpath manpath

# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit


HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

# Default Editor
export EDITOR="hx"

# XDG Path Setup
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
  --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

source <(fzf --zsh)

# Ghostty Setup
export PATH=$PATH:$GHOSTTY_BIN_DIR

# fnm
eval "$(fnm env --use-on-cd)"

# Carapace
export CARAPACE_BRIDGES='zsh,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# Aliases
alias -- cd=z
alias -- code=code-insiders
alias -- g=git
alias -- grep=rg
alias -- la='eza -a'
alias -- ll='eza -lah'
alias -- ls=eza
alias -- lt='eza -lah --tree'
alias -- man=batman
alias -- nix-shell='nix-shell --run $SHELL'
alias -- rebuild='cd ~/ghq/github.com/archcorsair/nix-macos && nix flake update && darwin-rebuild switch --flake ~/ghq/github.com/archcorsair/nix-macos#mbp --show-trace'
alias -- tree='br -c :pt "$@"'
alias -- vimdiff='nvim -d'
alias -- whatismyip='curl -s '\''https://api.ipify.org?format=json'\'' | jq -r '\''.ip'\'''
alias -- wimi=whatismyip

# Zsh Syntax Highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Zsh Autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Zoxide
eval "$(zoxide init zsh)"

# Atuin
eval "$(atuin init zsh)"
