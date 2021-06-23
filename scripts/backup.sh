#! /bin/bash
set -x #echo on

# RC files
cp ~/.fortify.zsh ../files/fortify.zsh
cp ~/.zshrc ../files/zshrc

# vim stuff
cp ~/.config/nvim/fortify.vim ../files/config/nvim/fortify.vim
cp ~/.config/nvim/init.vim ../files/config/nvim/init.vim
cp ~/.config/nvim/lightline.vim ../files/config/nvim/lightline.vim
cp ~/.config/nvim/plugins.vim ../files/config/nvim/plugins.vim

# Misc
cp ~/.ssh/config ../files/ssh/config
cp ~/.gitignore_global ../files/gitignore_global
cp ~/.antLogging ../files/antLogging
cp /etc/wsl.conf ../files/wsl.conf

# Scripts
cp ~/.local/bin/change_java ./change_java
cp ~/.local/bin/jdtls ./jdtls
cp ~/.local/bin/switch ./switch
cp ~/.local/bin/fprmerge.py ./fprmerge.py
