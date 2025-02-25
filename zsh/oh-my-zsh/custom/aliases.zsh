ff() {
  local window_id
  window_id=$(aerospace list-windows --all | fzf --bind "enter:execute-silent(echo {} | awk '{print \$1}' | xargs aerospace focus --window-id)")

  # Optional: Check if a selection was made
  [[ -n "$window_id" ]] && aerospace focus --window-id "$window_id"
}

# Git
alias gs="git status"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push"
alias ga="git add"
alias gd="git diff"

# Important dirs
alias dk="cd ~/Desktop"
alias dw="cd ~/Downloads"
alias ond="cd ~/"
alias dma="cd ~/Uni/Courses/DMA/"
alias pop="cd ~/Uni/Courses/PoP/"
alias cdid="cd ~/Uni/Courses/ID/"
alias cdsu="cd ~/Uni/Courses/SU/"
alias obd="cd ~/Obsidian/DatalogiVault/"
alias cdnvim="cd ~/.config/nvim/"
alias cdbn="cd ~/Box\ Sync/Programming/Python/Bots/nerds-bot/"

# Dotfiles repository
alias dotf="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Open books
alias clrs="open ~/Uni/Courses/DMA/Introduction_to_Algorithms_4th_edition.pdf"
alias ihc="open ~/Uni/Courses/ID/Introduction-HumanComputer-Interaction.pdf"

# Neovim distros
alias astrovim="NVIM_APPNAME=astrovim nvim"
alias nvchad="NVIM_APPNAME=nvchad nvim"
alias lazyvim="NVIM_APPNAME=lazyvim nvim"
alias knvim="NVIM_APPNAME=knvim nvim"

# Random
alias c="clear"
alias python="python3"
alias ls="lsd"
alias ord="cd ~/Box\ Sync/Danes\ Worldwide/Grammatik/Ordforrad; python ordforrad.py"
