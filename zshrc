# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export ZSH=$HOME/.oh-my-zsh

export XDG_CONFIG_HOME="$HOME/.config"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

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
plugins=(
    git
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
)

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


# Common aliases
alias lg="lazygit"

# IDE Aliases
alias cvim="NVIM_APPNAME=NvChad nvim"
alias avim="NVIM_APPNAME=AstroNvim nvim"
alias lvim="NVIM_APPNAME=LazyVim nvim"

# sudo IDE Aliases
alias cvim!="sudo NVIM_APPNAME=NvChad nvim"
alias avim!="sudo NVIM_APPNAME=AstroNvim nvim"
alias lvim!="sudo NVIM_APPNAME=LazyVim nvim"

function e() {
    local config="default"
    local default_ide="LazyVim"
    local items=( "default" "NvChad" "AstroNvim" "LazyVim" )

    local is_forse=$([[ "$1" = "-f" ]]; echo $?)
    local is_forse_search=$([[ "$1" = "-fs" ]]; echo $?)
    local is_search=$([[ "$1" = "-s" ]]; echo $?)

    if [[ $is_forse == 0 || $is_search == 0 || $is_forse_search == 0 ]] then
        shift
    fi

    if [[ $is_search != 0 && $is_forse_search != 0 ]]; then
        config=$default_ide
    else
        config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Configs 󱈇  " --height=~50% --layout=reverse --border --exit-0)

        if [[ -z $config ]]; then
            echo "Nothing selected"
            return 0
        elif [[ $config == "default" ]]; then
            config=""
        fi
    fi

    if [[ $is_forse == 0 || $is_forse_search == 0 ]] then
        sudo NVIM_APPNAME=$config nvim $@
    else
        NVIM_APPNAME=$config nvim $@
    fi
}

test -e /Users/paymentop.alex.belost/.iterm2_shell_integration.zsh && source /Users/paymentop.alex.belost/.iterm2_shell_integration.zsh || true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
