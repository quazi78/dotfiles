if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # Remove greeting
    set -U fish_greeting

    # Aliases
    alias vim="nvim"
    alias v="nvim"
    alias ls="ls --color=auto"
    alias ll="ls -la"
    alias grep="grep --color=auto"
    alias c="clear"
    alias ..="cd .."
    alias ...="cd ../.."
    
    # Git aliases
    alias g="git"
    alias ga="git add"
    alias gc="git commit -m"
    alias gp="git push"
    alias gs="git status"
    alias gl="git log --oneline --graph --decorate"
    alias gd="git diff"
    
    # Tmux aliases
    alias t="tmux"
    alias ta="tmux attach"
    alias tn="tmux new -s"
    
    # Environment Variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/.ripgreprc
    
    # Path
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/go/bin
    fish_add_path $HOME/.cargo/bin

    # Oh My Posh
    if type -q oh-my-posh
        oh-my-posh init fish --config $HOME/.config/omp/zen.toml | source
    end
    
    # Zoxide (better cd)
    if type -q zoxide
        zoxide init fish | source
    end
    
    # Starship (alternative to OMP if preferred)
    # if type -q starship
    #     starship init fish | source
    # end
end
