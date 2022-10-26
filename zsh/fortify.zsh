# ----------------
#Vars
# ----------------
export RULES=$HOME/rules
export ANT_OPTS="-Xmx4g -Xss1024M -Dant.logger.defaults=$HOME/.antLogging"
export ANT_ARGS="-logger org.apache.tools.ant.listener.AnsiColorLogger"
export SCRATCH="/mnt/c/Users/Dude/Scratch"
export DOWNLOADS="/mnt/c/Users/Dude/Downloads"
export SAM_CLI_TELEMETRY=0 #Disable AWS telemetry

# ----------------
# Personal Aliases
# ----------------
alias fortifyrc="vi $HOME/.fortify.zsh"
alias scratch="cd $SCRATCH"
alias bugs="cd $WORK/bugs"
alias rules="cd $RULES"
alias finit="nvim $HOME/.config/nvim/fortify.vim"
alias sourceanalyzer="~/.local/bin/sourceanalyzer"
alias scav="sourceanalyzer -v"
alias sca='sourceanalyzer'

# ------------------
# Personal Functions
# ------------------

#
# Update rules in the SCA dirs
#
function updateRules(){
    local new_rules="${RULES}/build/en/bin"
    if [ "$#" -eq 1 ]; then new_rules=$1; echo "Copying from $1";fi

    cp $new_rules/*.bin $HOME/SCA/sca/_stage/SCA/Core/config/rules
    echo "[updateRules] SCA Dev repo updated"

    for i in $(/usr/bin/ls $HOME/SCA | grep Fortify_SCA_and_Apps)
    do
        cp $new_rules/*.bin $HOME/SCA/$i/Core/config/rules
        echo "[updateRules] $HOME/SCA/$i/Core/config/rules updated"
    done
    echo "[updateRules] Done"
}

#
# Search for a description
# Opens up fzf to narrow down results
#
function desc(){
    if [ "$#" -ne 1 ]; then echo "Usage: desc <description or string>"; return 1; fi

    local query=${*:-}
    local selected
    IFS=$'\n' selected=($(
        rg --color=always --line-number --no-heading --smart-case "$query" $RULES/descriptions/en |
        fzf --ansi \
            --height=60% \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2} --style=numbers,snip'  \
            --preview-window 'down:75%:+{2}+3/3' |
        cut -d':' -f1 |
        sort -u
    ))
    [[ -n "${selected}" ]] && $EDITOR -c "silent! /$query" ${selected[@]} && echo $EDITOR ${selected[@]}
}

#
# Searches the rulepack for a matching pattern
# opens vim
# highlights the pattern
#
function grule(){ 
    if [ "$#" -ne 1 ]; then echo "Usage: grule <ruleID or string>"; return 1; fi

    local query=${*:-}
    local selected
    IFS=$'\n' selected=($(
        rg --color=always --line-number --no-heading --smart-case "$query" $RULES/src |
        fzf --ansi \
            --height=60% \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2} --style=numbers,snip'  \
            --preview-window 'down:75%:+{2}+3/3' |
        cut -d':' -f1 |
        sort -u
    ))
    [[ -n "${selected}" ]] && $EDITOR -c "silent! /$query" ${selected[@]} && echo $EDITOR ${selected[@]}
}

#
# Shamelessly stolen from Wenhao
# Downloads the NOK fpr from filer
#
function noks(){
    if [ "$#" -ne 3 ]; then echo "[noks] Usage: noks <rules version> <sca version> <project name>"; return 1; fi

    # NOTE: Manually Update
    local currentQuarter="Pavlova"
    local rootDirName="rules3"
    ######

    local rules_version=$1
    local sca_version=$2
    local proj_name=$3
    local url="[REDACTED]"

    # echo $url
    wget -P $DOWNLOADS $url
}

#
# Creates the js lsp config file
#
function jslspconf(){
    echo '{
  "compilerOptions": {
    "module": "commonjs",
    "target": "es6",
    "checkJs": true
  },
  "exclude": [
    "node_modules"
  ]
}
'> jsconfig.json
}
