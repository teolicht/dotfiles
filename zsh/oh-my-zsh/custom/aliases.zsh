ff() {
  local window_id
  window_id=$(aerospace list-windows --all | fzf --bind "enter:execute-silent(echo {} | awk '{print \$1}' | xargs aerospace focus --window-id)")

  # Optional: Check if a selection was made
  [[ -n "$window_id" ]] && aerospace focus --window-id "$window_id"
}

openwin() { osascript -e "tell application \"$1\" to activate" -e 'tell application "System Events" to keystroke "n" using command down'; }

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
alias luni="cd ~/Documents/LocalUni"
alias ond="cd ~/Library/CloudStorage/OneDrive-UniversityofCopenhagen/"
alias dma="cd ~/Uni/Courses/DMA/"
alias pop="cd ~/Uni/Courses/PoP/"
alias la="cd ~/Uni/Courses/LA/"
alias cdid="cd ~/Uni/Courses/ID/"
alias cdsu="cd ~/Documents/Projects/SU/"
alias obd="cd ~/Documents/Obsidian/DatalogiVault/"
alias cdnvim="cd ~/.config/nvim/"
alias cdbn="cd ~/Documents/Projects/Python/Bots/nerds-bot/"

# Open books
alias clrs="open ~/Uni/Courses/DMA/Introduction_to_Algorithms_4th_edition.pdf"
alias ihc="open ~/Uni/Courses/ID/Introduction-HumanComputer-Interaction.pdf"

# Neovim distros
alias astronvim="NVIM_APPNAME=astronvim nvim"
alias nvchad="NVIM_APPNAME=nvchad nvim"
alias lazyvim="NVIM_APPNAME=lazyvim nvim"
alias knvim="NVIM_APPNAME=knvim nvim"

# Random
alias c="clear"
alias ls="lsd"
alias ord="cd ~/Documents/Projects/Python/Ordforrad/; python ordforrad.py"

# Server
alias sv="ssh teolicht@mm.cloudmin.anu.net"
