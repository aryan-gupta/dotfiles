#!/bin/zsh

# If we are starting in a tty session then go ahead and start our window
# manager
STARTX_LOGDIR="${HOME}/.local/share/startx/"
export LOGOUT_FILE="/tmp/boson-aryan-donotstartwm"
mkdir -p $STARTX_LOGDIR
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && [ ! -f "$LOGOUT_FILE" ]; then
  echo "$(date)" | tee $LOGOUT_FILE
  echo "$(date)" >> "${STARTX_LOGDIR}/startx.log"
  echo "$(date)" >> "${STARTX_LOGDIR}/startx.err"

  exec startx >> "${STARTX_LOGDIR}/startx.log" 2>> "${STARTX_LOGDIR}/startx.err"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# https://stackoverflow.com/questions/62931101
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  history-substring-search
)

source $ZSH/oh-my-zsh.sh
source /etc/profile

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export PATH="$PATH:$HOME/.local/bin:$HOME/.config/bin"

if command -v ruby &> /dev/null
then
    export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
    export PATH="$PATH:$GEM_HOME/bin"
fi

# Needed for bspwm java windows
export _JAVA_AWT_WM_NONREPARENTING=1

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias f="ranger"
alias v="vim"
alias sv="sudo vim"
alias p="zathura"
alias n="ncmpcpp"
alias pacman="sudo pacman"
alias apt="sudo apt"
alias gitk="gitk --all &"
source ~/.cmd-shortcuts

# Config for Spaceship prompt
SPACESHIP_PROMPT_ORDER=(
  # time          # Time stampts section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  # hg            # Mercurial section (hg_branch  + hg_status)
  # package       # Package version
  # node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  # xcode         # Xcode section
  # swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  # rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  docker        # Docker section
  # aws           # Amazon Web Services section
  venv          # virtualenv section
  # conda         # conda virtualenv section
  # pyenv         # Pyenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  # kubecontext   # Kubectl context section
  exec_time     # Execution time
  line_sep      # Line break
  # battery       # Battery level and status
  # vi_mode       # Vi-mode indicator
  # jobs          # Background jobs indicator
  # exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
  battery
  jobs
  exit_code
  time
)

SPACESHIP_TIME_SHOW=true
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_JOBS_SYMBOL="\xE2\x80\xA2"

# SPACESHIP_PROMPT_ADD_NEWLINE=false
# SPACESHIP_HOST_SHOW_FULL=true
# SPACESHIP_HOST_SUFFIX=".gempi.re "
# SPACESHIP_CHAR_SYMBOL="»"

setopt HIST_IGNORE_SPACE

# bind ctrl+Backspace to delete word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
#bindkey "^[[A" history-beginning-search-backward
#bindkey "^[[B" history-beginning-search-forward

# allows gpg to use terminal for password input
export GPG_TTY="$( tty )"

# https://unix.stackexchange.com/questions/356753
export SYSTEMD_PAGER=cat
export PAGER=cat
