# Set the number of commands to remember in the current session and save in the history file
HISTSIZE=10_000
SAVEHIST=10_000

# Options for managing history
setopt appendhistory      # Append commands to the history file, don't overwrite
setopt sharehistory       # Share history across all sessions
setopt inc_append_history # Immediately add commands to the history file

eval "$(ssh-agent -s)"
eval "$(starship init zsh)"

export EDITOR=nano

# proto
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
