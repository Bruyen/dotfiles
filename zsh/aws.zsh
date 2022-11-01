# ----------------
#Vars
# ----------------
export PATH=/usr/local/opt/curl/bin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/lib/ruby/gems/3.1.0/bin:$PATH
export SAM_CLI_TELEMETRY=0 #Disable AWS telemetry
export SCRATCH="$HOME/Scratch"
export PATH=$PATH:$HOME/.toolbox/bin

#
# ----------------
# Personal Aliases
# ----------------
alias awsrc="vi $HOME/.aws.zsh"
alias scratch="cd $SCRATCH"
