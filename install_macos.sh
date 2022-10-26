#/bin/bash

echo "[dotfiles - install.sh] Start"

DOTFILES=$(pwd)

echo "[dotfiles - install.sh] Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off # Disable brew analytics

echo "[dotfiles - install.sh] Brew packages"
packages="wget bat curl neovim python ruby fzf ripgrep"
brew install $packages

echo "[dotfiles - install.sh] home"
# ln -sf "$DOTFILES/home/antLogging" "$HOME/.antLogging"
ln -sf "$DOTFILES/home/gitignore_global" "$HOME/.gitignore_global"

echo "[dotfiles - install.sh] zsh"
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/fzf_functions.zsh" "$HOME/.fzf_functions.zsh"
ln -sf "$DOTFILES/zsh/aws.zsh" "$HOME/.aws.zsh"

# packages="vim zsh tmux openjdk-8-jdk ant build-essential git curl python cifs-utils software-properties-common python-dev python3-dev autoconf pkg-config golang ruby ruby-dev scala maven net-tools python3-pip p7zip-full bat"
# sudo apt update
# sudo apt install -y $packages


echo "[dotfiles - install.sh] pip packages"
# pip3_packages="setuptools neovim lxml Requests ply whoosh jsbeautifier exrex pyparsing Pygments thefuck python-language-server"
pip3_packages="neovim Pygments"
pip3 install $pip3_packages

# echo "[dotfiles - install.sh] vim plug"
# curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# pip3 install $pip3_packages --user

# echo "[dotfiles - install.sh] vim configs"
mkdir -p $HOME/.config/nvim
ln -sf "$DOTFILES/nvim/init.vim" "$HOME/.config/nvim/init.vim"
ln -sf "$DOTFILES/nvim/lightline.vim" "$HOME/.config/nvim/lightline.vim"
ln -sf "$DOTFILES/nvim/plugins.vim" "$HOME/.config/nvim/plugins.vim"
# ln -sf "$DOTFILES/nvim/fortify.vim" "$HOME/.config/nvim/fortify.vim"
# ln -sf "$DOTFILES/nvim/fortify.snippets" "$HOME/.config/nvim/plugged/vim-snippets/UltiSnips"

echo "[dotfiles - install.sh] default zsh"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.powerlevel9k
# sudo chsh -s $(which zsh)
# chsh -s $(which zsh)

echo "[dotfiles - install.sh] colorls"
git clone https://github.com/athityakumar/colorls.git ~/.colorls
(cd ~/.colorls; sudo gem install colorls; cd -)
# TODO: Manually add colorls to path; use `gem env` to find install dir

echo "[dotfiles - install.sh] Fast Syntax Highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.fast-syntax-highlighting

# echo "[dotfiles - install.sh] ctags"
# git clone https://github.com/universal-ctags/ctags.git ~/.ctags
# cd ~/.ctags
# ./autogen.sh
# ./configure
# make
# sudo make install
# cd ~


## Manual Steps

## clone dis -> github.com/universal-ctags/ctags/blob/master/docs/autotools.rst
# Change terminal font to DroidSansMono Nerd Font Book
# git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/.nerd-fonts
# ~/.nerd-fonts/install.sh UbuntuMono

# Java LSP, After nvim PlugInstall
# cd ~/.config/nvim/plugged/eclipse.jdt.ls
# ./mvnw clean verify
# cp scripts/jdtls ~/.local/bin/.

# Gopls, After nvim PlugInstall
# GO111MODULE=on go get golang.org/x/tools/gopls@latest
echo "[dotfiles - install.sh] Done"
