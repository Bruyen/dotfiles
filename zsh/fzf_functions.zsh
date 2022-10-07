# ----------------
#  Functions with FZF and RG
# ----------------
# TODO: Add --header 'SOME MESSAGE' to some functions

#
# Pass selected files as arguments to the given command
# Usage: f echo
# Usage: f vim
#
f() {
    if [ ! "$#" -gt 0 ]; then echo "Usage: f <command>"; return 1; fi

    local files
    IFS=$'\n' files=($(fzf --multi --select-1 --exit-0))
    [[ -n "$files" ]] && $1 "${files[@]}" && echo $1 ${files[@]}
}

# frg - Open the selected file with the pattern found by rg
# See: https://github.com/junegunn/fzf/blob/master/ADVANCED.md#ripgrep-integration
frg(){
    if [ "$#" -ne 1 ]; then echo "Usage: frg <query>"; return 1; fi

    local query=${*:-}
    local selected
    IFS=$'\n' selected=($(
        rg --color=always --line-number --no-heading --smart-case "$query" |
        fzf --ansi \
            --height=60% \
            --delimiter : \
            --preview 'batcat --color=always {1} --highlight-line {2} --style=numbers,snip'  \
            --preview-window 'down:75%:+{2}+3/3' |
        cut -d':' -f1 |
        sort -u
    ))
    [[ -n "${selected}" ]] && $EDITOR -c "silent! /$query" ${selected[@]} && echo $EDITOR ${selected[@]}
}

# fv [FUZZY PATTERN] - Open the selected files with neovim 
fvi() {
    local files
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && $EDITOR "${files[@]}" && echo $EDITOR ${files[@]}
}

# fd - cd to selected directory
fcd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
                    -o -type d -print 2> /dev/null | fzf --no-multi +m) &&
    cd "$dir"
}

# fh - repeat history
fhistory() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

#
# Will return non-zero status if the current directory is not managed by git
#
is_in_git_repo(){
    git rev-parse HEAD > /dev/null 2>&1
}

#
# _fgh - FZF git hash
#
# Uses FZF to select a git hash
# Shows a shortened git log and a summary of the commit
# Returns the hash of the chosen commit
#
_fgh() {
    is_in_git_repo || return

    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
    fzf --no-multi --height=50% --ansi --no-sort --reverse --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{9,\}" <<< {} | xargs git show --color=always' |
    grep -o "[a-f0-9]\{9,\}"
}

#
# fgd - FZF git diff
#
# Uses FZF to select an unstaged file
# Preview shows the diff
# Returns the relative path of the file
#
_fgd() {
    is_in_git_repo || return

    git -c color.status=always status --short |
    fzf --height=50% -m --ansi --preview-window right:75% --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; batcat --color=always {-1} --style=numbers,snip)' |
    cut -c4- | sed 's/.* -> //'
}

#
# fga - FZF git add
#
# Stage the selected files
#
fga(){
    is_in_git_repo || return

    local files
    IFS=$'\n' files=($(_fgd))
    [[ -n "$files" ]] && git add ${files[@]} && echo "\ngit add ${files[@]}"
}

#
# fgch - FZF git checkout
#
# Checkout a chosen branch
#
fgch(){
    is_in_git_repo || return

    git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf --no-multi --height=50% --ansi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##' | xargs git checkout
}

#
# fgdf - FZF git diff file
#
# See the diff of a chosen file
#
fgd(){
    is_in_git_repo || return

    _fgd | xargs git diff
}

#
# fgl - FZF git diff hash
#
# See the diff of a chosen commit
#
fgl() {
    is_in_git_repo || return

    _fgh | xargs git diff
}

#
# fgsp - FZF git stash pop
#
# Pop the chosen stash
#
fgsp(){
    is_in_git_repo || return

    git stash list |
    fzf --no-multi --height=50% --reverse -d: --preview 'git show --color=always {1}' |
    cut -d: -f1 |
    xargs git stash pop
}

#
# fgt - FZF git tag
#
# Uses FZF to select a tag
# Preview shows a brief summary of changes
# Returns the tag name
#
fgt() {
    is_in_git_repo || return

    git tag --sort -version:refname |
    fzf --height=50% --multi --preview-window right:75% \
    --preview 'git show --color=always {}'
}

#
# Opens the selected file and uses FZF to select/search contents
#
contents(){
    local query=$(fzf --no-multi --header 'Select a file')
    if [[ -n "${query}" ]]
    then
        rg --color=always --line-number --no-heading --smart-case "" $query |
        fzf --ansi \
            --height=60% |
        cut -d':' -f2
    fi
}
