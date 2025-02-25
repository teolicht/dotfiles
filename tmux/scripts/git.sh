#!/usr/bin/env bash

export LC_ALL=en_US.UTF-8

# Icons (customize as desired)
GIT_ICON=""
BRANCH_ICON=""
NO_REPO_MESSAGE=""

# Get the active pane's current working directory
get_pane_dir() {
    tmux display-message -p -F "#{pane_current_path}"
}

# Check if the directory is a Git repository
is_git_repo() {
    git -C "$1" rev-parse --is-inside-work-tree >/dev/null 2>&1
    echo $?
}

# Get the current repository name
get_repo_name() {
    git -C "$1" rev-parse --show-toplevel 2>/dev/null | xargs basename
}

# Get the current branch name
get_branch_name() {
    git -C "$1" rev-parse --abbrev-ref HEAD 2>/dev/null
}

# Main function to display the Git information
get_git_info() {
    path=$(get_pane_dir)
    if [ "$(is_git_repo "$path")" -eq 0 ]; then
        repo_name=$(get_repo_name "$path")
        branch_name=$(get_branch_name "$path")
        # echo "$GIT_ICON $repo_name $BRANCH_ICON $branch_name"
        echo "$GIT_ICON  $BRANCH_ICON $branch_name"
    else
        echo "$NO_REPO_MESSAGE"
    fi
}

get_git_info
