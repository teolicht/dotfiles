# Git
# *The `git` oh-my-zsh plugin defines many more
alias gs="git status"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gP="git push"
alias gp="git pull"
alias ga="git add"
alias gd="git diff"

# Directories 
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias df="cd ~/.dotfiles/"
alias cfg="cd ~/.config/"
alias uni="cd ~/Uni"
alias puni="cd ~/Documents/UniPython/"
alias move="python3 ~/Documents/UniPython/move.py"
alias ond="cd ~/Library/CloudStorage/OneDrive-DanmarksTekniskeUniversitet/"
alias cdnvim="cd ~/.config/nvim/"
alias cdbn="cd ~/Documents/Projects/Python/Bots/nerds-bot/"

# Neovim distros
alias astronvim="NVIM_APPNAME=astronvim nvim"
alias nvchad="NVIM_APPNAME=nvchad nvim"
alias lazyvim="NVIM_APPNAME=lazyvim nvim"
alias knvim="NVIM_APPNAME=knvim nvim"

# Random
alias c="clear"
alias e="echo"
alias ls="lsd"
alias ord="cd ~/Documents/Projects/Python/Ordforrad/; python3 ordforrad.py"
alias unvim="uv run nvim"
alias upython="uv run python"
alias sympy="cd ~/Documents/UniPython/; uv run python -i init_sympy.py"

alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

alias rmd="rm -rf"
alias copy="pbcopy"

alias sbon="sketchybar --bar hidden=off"
alias sboff="sketchybar --bar hidden=on"

# Cpp
alias cppbuild="clang++ -g -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -pedantic-errors -std=c++23"

# --- FUNCTIONS ---
#
cppbuildrun() {
    cppbuild -o "${1%.cpp}" "$1" && "./${1%.cpp}"
}

ff() {
  local window_id
  window_id=$(aerospace list-windows --all | fzf --bind "enter:execute-silent(echo {} | awk '{print \$1}' | xargs aerospace focus --window-id)")

  # Optional: Check if a selection was made
  [[ -n "$window_id" ]] && aerospace focus --window-id "$window_id"
}

openwin() { 
  osascript -e "tell application \"$1\" to activate" -e 'tell application "System Events" to keystroke "n" using command down'; 
}


# Make directory and cd into it
mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

# cd into directory and check contents
cdls () {
  \cd "$1"
  ls
}

boop() {
  "$@"
  local last=$?
  if [[ $last -eq 0 ]]; then
    notify "'$*' is done, SUCCESS"
  else
    notify "'$*' is done, FAILURE"
  fi
  return $last
}

