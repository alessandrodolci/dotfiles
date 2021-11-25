# This file is sourced everytime ZSH is launched.
# This means login/non-login interactive shells and single command shells,
# even if launched by other tools.

# Configure PATH to include user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    path+=("$HOME/.local/bin")
fi

# Configure PATH to include Play2 Activator path if it exists
if [ -d "$HOME/.local/bin/activator-1.3.12-minimal/bin" ]; then
    path+=("$HOME/.local/bin/activator-1.3.12-minimal/bin")
fi

# Configure PATH to include Sencha Cmd path if it exists
if [ -d "$HOME/.local/bin/Sencha/Cmd/7.0.0.40" ]; then
    path+=("$HOME/.local/bin/Sencha/Cmd/7.0.0.40")
fi

# Configure PATH to include JMeter path if it exists
if [ -d "$HOME/.local/bin/apache-jmeter-5.4.1/bin" ]; then
    path+=("$HOME/.local/bin/apache-jmeter-5.4.1/bin")
fi
