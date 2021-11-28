#/bin/bash

PROFILE_FILE=~/.bashrc

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source $PROFILE_FILE
nvm install 14 && nvm install 10

# install Vim as a IDE
sudo yum install -y vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp .vimrc ~/.vimrc

# Install VSCode
sudo cp vscode.repo /etc/yum.repos.d/vscode.repo
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf update
sudo dnf install code
# VSCode extensions
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension vscodevim.vim
code --install-extension sonarsource.sonarlint-vscode
code --install-extension syler.sass-indented

# GIT
cp ssh-config ~/.ssh/config


