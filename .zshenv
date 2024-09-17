# This file is sourced everytime ZSH is launched.
# This means login/non-login interactive shells and single command shells,
# even if launched by other tools.

# Configure PATH to include user's private bin if it exists
USER_BIN_PATH="$HOME/.local/bin"
if [ -d $USER_BIN_PATH ]; then
    path+=($USER_BIN_PATH)
fi

# Configure PATH to include Play2 Activator path if it exists
PLAY2_PATH="$HOME/.local/bin/activator-1.3.12-minimal/bin"
if [ -d $PLAY2_PATH ]; then
    path+=($PLAY2_PATH)
fi

# Configure PATH to include Sencha Cmd path if it exists
SENCHA_CMD_PATH="$HOME/.local/bin/Sencha/Cmd/7.0.0.40"
if [ -d $SENCHA_CMD_PATH ]; then
    path+=($SENCHA_CMD_PATH)
fi

# Configure PATH to include JMeter path if it exists
JMETER_PATH="$HOME/.local/bin/apache-jmeter-5.4.1/bin"
if [ -d $JMETER_PATH ]; then
    path+=($JMETER_PATH)
fi

# Configure PATH to include JetBrains Toolbox
JETBRAINS_TOOLBOX_PATH="$HOME/.local/share/JetBrains/Toolbox/scripts"
if [ -d $JETBRAINS_TOOLBOX_PATH ]; then
    path+=($JETBRAINS_TOOLBOX_PATH)
fi

# Enforce AWS default profile setting
export AWS_PROFILE=alessandro
