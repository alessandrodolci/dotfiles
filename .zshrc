# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/alessandro/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Update operations
function perform_updates() {
    echo "Updating zsh-async..."
    cd ~/.zsh-async/ && git fetch && git pull
    echo "Updating powerlevel10k..."
    cd ~/.powerlevel10k/ && git fetch && git pull
    echo "Updating nvm..."
    cd ~/.nvm/ && git fetch && git pull
    echo "Done."
    echo "$(date +%s)" > ~/.zsh-update

    cd ~
}

if [ -f ~/.zsh-update ]; then
    LAST_UPDATE_TIME=$(cat ~/.zsh-update)
else
    LAST_UPDATE_TIME=0
    echo "$LAST_UPDATE_TIME" > ~/.zsh-update
fi
CURRENT_TIMESTAMP=$(date +%s)
(( TIME_SINCE_UPDATE = ($CURRENT_TIMESTAMP - $LAST_UPDATE_TIME) / 60 / 60 ))
if [ $TIME_SINCE_UPDATE -gt 336 ]; then
    echo "Do you wish to update the zsh environment?"
    while true; do
        read ANSWER
        case $ANSWER in
            [Yy]|yes )
                perform_updates
                ;;
            [Nn]|no )
                ;;
            * )
                echo "Please answer yes or no."
                read ANSWER
                ;;
        esac
    done
fi

# Source zsh-async
source ~/.zsh-async/async.zsh

# Enable powerlevel10k theme
source ~/.powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable color support of ls and also add handy aliases
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

# Enable case-insensitive completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

# Asynchronously source nvm
export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}
async_start_worker nvm_worker -n
async_register_callback nvm_worker load_nvm
async_job nvm_worker sleep 0.1
