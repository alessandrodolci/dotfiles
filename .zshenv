# This file is sourced everytime ZSH is launched.
# This means login/non-login interactive shells and single command shells,
# even if launched by other tools.

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    path+=("$HOME/.local/bin")
fi

# Set PATH so it includes Play2 Activator path if it exists
if [ -d "$HOME/.local/bin/activator-1.3.12-minimal/bin" ]; then
    path+=("$HOME/.local/bin/activator-1.3.12-minimal/bin")
fi

# Set PATH so it includes Sencha Cmd path if it exists
if [ -d "$HOME/.local/bin/Sencha/Cmd/7.0.0.40" ]; then
    path+=("$HOME/.local/bin/Sencha/Cmd/7.0.0.40")
fi
