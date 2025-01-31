# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$HOME/go/bin:/usr/local/sbin:/usr/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
lemonade server &> /dev/null &
# alias 2='et -r 2489:2489 devvm14421.vll0.facebook.com:8080'
# alias 3='et -r 2489:2489 devgpu005.ncg5.facebook.com:8080'
# alias 2='et devgpu005.ncg5.facebook.com -r 2489:2489'
alias ssh-nv5='ssh devgpu005.ncg5.facebook.com'
alias ssh-nv8='ssh devgpu008.ncg5.facebook.com'
alias ssh-nv9='ssh devgpu009.lla1.facebook.com'
alias ssh-nv36='ssh devgpu036.cln6.facebook.com'
alias ssh-nv186='ssh devvm186.ldc0.facebook.com'
alias ssh-h1='ssh devvm16059.nha0.facebook.com'
alias ssh-h2='ssh devvm15316.frc0.facebook.com'

alias od='x2ssh -et 39985.od.fbinfra.net -r 2489:2489'
alias nv5='x2ssh -et devgpu005.ncg5.facebook.com -r 2489:2489'
alias nv8='x2ssh -et devgpu008.ncg5.facebook.com -r 2489:2489'
alias nv36='x2ssh -et devgpu036.cln6.facebook.com -r 2489:2489'
alias nv186='x2ssh -et devvm186.ldc0.facebook.com -r 2489:2489'
alias nv9='x2ssh -et devgpu009.lla1.facebook.com -r 2489:2489'
alias amd27='x2ssh -et devgpu027.prn3.facebook.com -r 2489:2489'
alias nvh1='x2ssh -et devvm16059.nha0.facebook.com -r 2489:2489'
alias nvh2='x2ssh -et devvm15316.frc0.facebook.com -r 2489:2489'

alias v=nvim
alias pr='pipenv run'

# >>> setup vi mode
# bindkey -v
# function zle-keymap-select {
#     if [[ ${KEYMAP} == vicmd ]] ||
#         [[ $1 = 'block' ]]; then
#         echo -ne '\e[1 q'
#     elif [[ ${KEYMAP} == main ]] ||
#              [[ ${KEYMAP} == viins ]] ||
#              [[ ${KEYMAP} = '' ]] ||
#              [[ $1 = 'beam' ]]; then
#         echo -ne '\e[5 q'
#     fi
# }
# zle -N zle-keymap-select
# echo -ne '\e[5 q'; zle -R # Use beam shape cursor on startup.
# bindkey -v
# bindkey '^P' up-history
# bindkey '^N' down-history
# bindkey '^?' backward-delete-char
# autoload -Uz add-zsh-hook
# add-zsh-hook zle-line-init zle-keymap-select
# add-zsh-hook zle-keymap-select zle-keymap-select
# bindkey -M vicmd '^R' history-incremental-search-backward
# bindkey -M viins '^R' history-incremental-search-backward
# <<< end set up vi mode

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/xianxu/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/xianxu/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/xianxu/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/xianxu/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/xianxu/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward


source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.4.1
