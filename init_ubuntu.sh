#/bin/bash

# TODO: separate nvim configs
# Moving config Files
# for i in $(ls -1 files); do
#     cp -r files/$i ~/.$i
# done

# cp -r files/config/ ~/.config
cp files/antLogging ~/.antLogging
cp -r files/fortify.zsh ~/.fortify.zsh
cp -r files/gitignore_global ~/.gitignore_global
cp -r files/zshrc ~/.zshrc
# cp -r files/wsl.conf /etc/wsl.conf

cp scripts/switch ~/.local/bin/switch
cp scripts/change_java ~/.local/bin/change_java
cp scripts/fprmerge.py ~/.local/bin/fprmerge.py
sudo chmod +x ~/.local/bin/switch
sudo chmod +x ~/.local/bin/change_java
sudo chmod +x ~/.local/bin/fprmerge.py

# TODO: Add back in when installing nvim 5.X is easy
# wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
# sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo add-apt-repository -y ppa:longsleep/golang-backports

packages="vim zsh tmux openjdk-8-jdk ant build-essential git curl python cifs-utils software-properties-common python-dev python3-dev autoconf pkg-config golang-1.13 fzf ruby ruby-dev scala maven net-tools python3-pip p7zip-full"
sudo apt update
sudo apt install -y $packages

# Fortify-vim requirements
pip3_packages="setuptools neovim lxml Requests ply whoosh jsbeautifier exrex pyparsing Pygments thefuck python-language-server"
# vim-plug install
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install $pip3_packages --user

# Default to zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.powerlevel9k
sudo chsh -s $(which zsh)
chsh -s $(which zsh)

# Install nerd-font
# NOTE: May need to manually install depending on OS
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/.nerd-fonts
~/.nerd-fonts/install.sh

# GoLang
sudo ln -s /usr/lib/go-1.13/bin/go /usr/bin/go
sudo ln -s /usr/lib/go-1.13/bin/gofmt /usr/bin/gofmt

# ColorLS
git clone https://github.com/athityakumar/colorls.git ~/.colorls
(cd ~/.colorls; sudo gem install colorls; cd -)

#ctags
git clone https://github.com/universal-ctags/ctags.git ~/.ctags
cd ~/.ctags
./autogen.sh
./configure
make
sudo make install
cd ~

# gradle
sudo mkdir gradle
wget https://services.gradle.org/distributions/gradle-6.8.2-all.zip
sudo unzip -d /opt/gradle gradle-6.8.2-all.zip

# ssh
# chmod 644 ~/.ssh/config
# chmod 644 ~/.ssh/id_rsa.pub
# chmod 644 ~/.ssh/known_hosts
# chmod 600 ~/.ssh/id_rsa

## Manual Steps
# sudo update-alternatives --config java #set to 8
# sudo chmod +x /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/libjvm.so
# sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2

## clone dis -> github.com/universal-ctags/ctags/blob/master/docs/autotools.rst
# Change terminal font to DroidSansMono Nerd Font Book

# Java LSP, After nvim PlugInstall
# cd ~/.config/nvim/plugged/eclipse.jdt.ls
# ./mvnw clean verify
# cp scripts/jdtls ~/.local/bin/.

# Gopls, After nvim PlugInstall
# GO111MODULE=on go get golang.org/x/tools/gopls@latest
