#!/usr/bin/env bash

function print_info() {
    tput bold
    echo -e "$1"
    tput sgr0
}

function clone_from_github() {
    if [ "$#" -ne 2 ]; then
        echo -e "Error cloning from GitHub: repository name is missing."
        return 1
    fi

    if [ -d "$2" ]; then
        echo -e "Error cloning from GitHub: $1 is already installed."
        return 2
    fi

    echo -e "\nInstalling $1..."
    git clone "git@github.com:$1.git" "$2"
    echo -e "Done."
}

function install_modules() {
    INITIAL_DIRECTORY=$(pwd)
    cd ~

    clone_from_github "romkatv/zsh-defer" ".zsh-defer"
    clone_from_github "romkatv/powerlevel10k" ".powerlevel10k"
    clone_from_github "nvm-sh/nvm" ".nvm"

    print_info "\nAll modules have been installed."
    cd $INITIAL_DIRECTORY
}

print_info "The following modules will be installed:\n"
echo -e "romkatv/zsh-defer"
echo -e "romkatv/powerlevel10k"
echo -e "nvm-sh/nvm"
print_info "\nDo you want to continue? [y/n]"

ANSWER=""
while test -z $ANSWER; do
    read ANSWER

    case $ANSWER in
        [Yy]|yes )
            install_modules
            ;;
        [Nn]|no )
            print_info "\nNo modules have been installed."
            ;;
        * )
            print_info "Please answer yes or no."
            ANSWER=""
            ;;
    esac
done
