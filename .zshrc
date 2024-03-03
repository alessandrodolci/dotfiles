fpath+=~/.zfunc

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/alessandro/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


function print_info() {
    tput bold
    echo "$1"
    tput sgr0
}

function perform_updates() {
    print_info "Updating powerlevel10k..."
    git -C ~/.powerlevel10k pull
    print_info "Updating nvm..."
    git -C ~/.nvm pull

    echo "\nDone."
}
alias update-zsh-env='perform_updates'

function terminate_updates() {
    print_info "\nThe zsh environment is up to date."
    print_info "Next check: $(date -d "+14 days")"

    echo "$(date +%s)" > ~/.zsh-update
}

function check_for_updates() {
    if [ -f ~/.zsh-update ]; then
        LAST_UPDATE_TIME=$(cat ~/.zsh-update)
    else
        LAST_UPDATE_TIME=0
        echo "$LAST_UPDATE_TIME" > ~/.zsh-update
    fi

    CURRENT_TIMESTAMP=$(date +%s)
    (( TIME_SINCE_UPDATE = ($CURRENT_TIMESTAMP - $LAST_UPDATE_TIME) / 60 / 60 ))

    if [ $TIME_SINCE_UPDATE -gt 336 ]; then
        print_info "Do you wish to update the zsh environment? [y/n]"

        ANSWER=""
        while test -z $ANSWER; do
            read ANSWER

            case $ANSWER in
                [Yy]|yes )
                    perform_updates
                    terminate_updates
                    ;;
                [Nn]|no )
                    terminate_updates
                    ;;
                * )
                    print_info "Please answer yes or no."
                    ANSWER=""
                    ;;
            esac
        done
    fi
}

# Prompt for environment updates
check_for_updates

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable powerlevel10k theme
source ~/.powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Configure styles and aliases for ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Bind keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^F" history-incremental-search-forward

# Enable case-insensitive completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

# Enable kubectl completion
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# Define alias for Laravel Sail binary
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

# Source nvm
export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}
load_nvm
