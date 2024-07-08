#/bin/bash

#
# Prerequisites
#
# -- SSH Key        - ssh-keygen -t ed25519

sudo apt install -y gcc make

#
# https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_12_.22Bookworm.22
#
# Before installing the drivers, you must obtain the proper kernel headers for the NVIDIA driver to build with.
# For a typical 64-bit system using the default kernel, you can simply run:
# sudo apt install -y linux-headers-amd64  # Maybe needed with proprietary driver?

#
# Steam - https://wiki.debian.org/Steam
#
dpkg --add-architecture i386 # For amd64 (64-bit) systems, enable Multi-Arch: 
sudo apt update
sudo apt install -y nvidia-driver-libs:i386
# For amd64 (64-bit) systems, additional libraries need to be installed for Vulkan and 32-bit titles
sudo apt install -y mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
sudo apt install -y steam-installer

#
# Spotify - https://www.spotify.com/de-en/download/linux/
#
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client

#
# dos2unix
#
sudo apt install -y dos2unix

# TODO: install wine

echo "[dotfiles - install.sh] Start"

DOTFILES=$(pwd)

#
# Shit doesn't work on FireFox sometimes
#
sudo apt install chromium

#
# Git
#
ln -sf "$DOTFILES/home/gitignore_global" "$HOME/.gitignore_global"
git config --global user.name "Bruyen"
git config --global user.email brucenguyen2841@gmail.com
git config --global core.excludesFile ~/.gitignore_global

echo "[dotfiles - install.sh] zsh"
sudo apt install -y zsh
chsh -s $(which zsh) # Verify /etc/passwd for effect
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/fzf_functions.zsh" "$HOME/.fzf_functions.zsh"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.powerlevel9k

echo "[dotfiles - install.sh] vim configs"
sudo apt install -y python3 python3-pip python3-neovim
mkdir -p $HOME/.config/nvim
ln -sf "$DOTFILES/nvim/init.vim" "$HOME/.config/nvim/init.vim"
ln -sf "$DOTFILES/nvim/lightline.vim" "$HOME/.config/nvim/lightline.vim"
ln -sf "$DOTFILES/nvim/plugins.vim" "$HOME/.config/nvim/plugins.vim"

echo "[dotfiles - install.sh] nvim"
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage # too lazy to build from source
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim

echo "[dotfiles - install.sh] bat"
sudo apt install -y python3-pygments
sudo apt install -y bat

echo "[dotfiles - install.sh] fzf + ripgrep"
sudo apt install ripgrep
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin --no-update-rc
sudo ln -sf ~/.fzf/bin/fzf /usr/local/bin/fzf

# https://github.com/nvbn/thefuck
echo "[dotfiles - install.sh] The Fuck"
sudo apt install thefuck

# TODO: I could just maintain a copy and copy it to the right dir. Not sure if I really care if the font is not up to date?
echo "[dotfiles - install.sh] nerdfont"
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/DejaVuSansMono.zip
unzip DejaVuSansMono.zip
sudo mv DejaVuSansM*.ttf /usr/local/share/fonts/.
fc-cache # Update font cache

echo "[dotfiles - install.sh] colorls"
sudo apt install -y ruby ruby-dev
git clone https://github.com/athityakumar/colorls.git ~/.colorls
(cd ~/.colorls; sudo gem install colorls; cd -)

echo "[dotfiles - install.sh] Fast Syntax Highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.fast-syntax-highlighting

# TODO: Emulate autogen.sh script pattern for error catching
echo "[dotfiles - install.sh] ctags"
sudo apt install -y dh-autoreconf autotools-dev pkg-config #deps 
git clone https://github.com/universal-ctags/ctags.git ~/.ctags
cd ~/.ctags
./autogen.sh
./configure
make
sudo make install
sudo cp ctags /usr/local/bin/.
cd -

#
# Manual Steps
#
# -- NVIDIA Drivers - https://www.nvidia.com/en-in/drivers/
# -- Virtualbox     - https://wiki.debian.org/VirtualBox
# -- Latest FireFox - https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions
# -- Unreal Engine  - https://www.unrealengine.com/en-US/linux
# --                - https://docs.unrealengine.com/4.27/en-US/SharingAndReleasing/Linux/BeginnerLinuxDeveloper/SettingUpAnUnrealWorkflow/
# -- Lutris         - https://lutris.net/downloads
# -- Change fonts to DejaVuSansMono
# -- Create a symbolic link of my Unreal projects into the Epic Games Launcher Dir
#    -- ln -sf /home/user/Documents/Unreal\ Projects /home/user/Games/epic-games-store/drive_c/users/user/Documents
# -- VSCodium       - https://github.com/VSCodium/vscodium
#    -- # Probable can automate this TODO

# TODO: Add Plasma config

echo "[dotfiles - install.sh] Done"
