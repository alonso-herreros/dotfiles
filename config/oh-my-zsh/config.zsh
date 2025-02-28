######################################################################
#                        Oh My Zsh! config                           #
######################################################################


# ===== Theme =====

# Set name of the theme to load --- if set to "random", it will load a random
# theme each time Oh My Zsh is loaded, in which case, to know which specific
# one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random Setting this variable
# when ZSH_THEME=random will cause zsh to load a theme from this variable
# instead of looking in $ZSH/themes/ If set to an empty array, this variable
# will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )


# ===== Options =====

# Use case-sensitive completion.
CASE_SENSITIVE="false"

# Use hyphen-insensitive completion. Case-sensitive completion must be off
HYPHEN_INSENSITIVE="true"

# Set to "true" if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="false"

# Disable colors in ls.
# DISABLE_LS_COLORS="false"

# Disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="false"

# Enable command auto-correction.
ENABLE_CORRECTION="false"

# Set to "true" to display red dots whilst waiting for completion.  You can
# also set it to another string to have that shown instead of the default red
# dots.  e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# COMPLETION_WAITING_DOTS="false"

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="false"

# Change the command execution time stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications, see
# 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"


# ===== Plugins =====

# Plugin list to load.
# Standard plugins are in $ZSH/plugins/, custom plugins in $ZSH_CUSTOM/plugins/
plugins=(git zoxide fzf)
