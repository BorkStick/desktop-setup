#!/bin/bash
# Bash Menu Script Example


# autokey-gtk vim i3 rofi htop tmux ffmpeg gdebi build-essential ffmpeg filezilla git curl hexchat gparted cmatrix exfat-fuse exfat-utils 
# dconf-cli software-properties-common openssh-server atom ranger obs-studio google-chrome-stable enpass vlc virtualbox gnome-tweaks vagrant 
# libcanberra-gtk0 libcanberra-gtk-module libgnome-keyring-common libgnome-keyring-dev

MinAppList="vim git curl unzip build-essential software-properties-common apt-transport-https wget openssh-server exfat-fuse exfat-utils htop"
BasicAppList="$MinAppList cmatrix alacritty ffmpeg tmux copyq shutter rofi filezilla ranger vlc"
DevAppList="nodejs npm python"
FullAppList="$BasicAppList hexchat gparted ansible" 
ManualAppList=""

# Functions



# min
#
# vim tmux htop git
min() {
    clear
    start
    sudo apt install -y $MinAppList
    
}

# basic
# 
#
basic() {
    clear
    start
    sudo apt install -y $BasicAppList
    dotfiles
    vscodeInstall
    copyqInstall
}

# full
#
#
full(){
    clear
    start
    sudo apt install -y $DevAppList
    sudo apt install -y $FullAppList
    dotfiles
    draculaTheme
    ytdlInstall
    vscodeInstall
    copyqInstall
    vscodePlugins
    zshInstall
}


# manual
#
#
manual() {
    clear
    start

    sudo apt install -y $ManualAppList

}

vscodePlugins() {
echo ""
echo "=================================="
echo " ADDING SOME SWEET VSCODE PLUGINS "
echo "=================================="
echo ""
echo ""

ext install Shan.code-settings-sync
ext install esbenp.prettier-vscode
ext install ritwickdey.LiveServer
ext install eamodio.gitlens
ext install vscode-icons-team.vscode-icons
ext install abusaidm.html-snippets
ext install xabikos.JavaScriptSnippets
ext install ecmel.vscode-html-css
ext install CoenraadS.bracket-pair-colorizer-2
ext install formulahendry.auto-rename-tag
ext install formulahendry.auto-close-tag
ext install DavidAnson.vscode-markdownlint
ext install yzhang.markdown-all-in-one
ext install streetsidesoftware.code-spell-checker
ext install wayou.vscode-todo-highlight
ext install shd101wyy.markdown-preview-enhanced
ext install oderwat.indent-rainbow
ext install Gruntfuggly.todo-tree




# theme
ext install dracula-theme.theme-dracula
}

start () {
echo ""
echo "=================================="
echo " Starting the $opt install "
echo "=================================="
echo ""
echo ""
}

dotfiles() {
#clear
echo ""
echo "========================="
echo " DEEZ DEM DOTFILES! "
echo "========================="
echo ""
echo ""

#----------
# dotfiles
#----------

# I should be able to set this shit up so it pulls my dotfiles from github/gitlab
# TODO: do get the dotfiles repo setup and working
git clone http://lab.borkslash.com/BorkStick/dotfiles-2019.git ~/dotfiles

# need to symlink them
sh ~/dotfiles/bootstrap.sh
}

# update and upgrade 
upup() {
sudo apt update -y && sudo apt upgrade -y
}

ytdlInstall() {
echo ""
echo "===================="
echo " Install Youtube-DL "
echo "===================="    
echo ""
echo ""
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
}

# vscode install
vscodeInstall() {
echo ""
echo "===================="
echo " Install VS Code "
echo "===================="    
echo ""
echo ""
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update -y
sudo apt install -y code
}

# copyq install
copyqInstall() {
echo ""
echo "===================="
echo " Install CopyQ "
echo "===================="    
echo ""
echo ""
sudo add-apt-repository ppa:hluk/copyq
sudo apt update -y
sudo apt install -y copyq
}

zshInstall() {
echo ""
echo "===================="
echo " Install ZSH and Oh My ZSH "
echo "===================="    
echo ""
echo ""
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# this will grab all my essential files that i use daily scripts / notes / projects
#
upAndRunning() {
echo ""
echo "===================="
echo " Doing the needful "
echo "===================="    
echo ""
echo ""
GITPASS=$1
if [ -z $1 ]
then
echo ""
printf "Enter the gitlab Password:\n"
read -s GITPASS
fi
cd ~/
git clone https://BorkStick:$GITPASS@lab.borkslash.com/borkstick/scripts.git
cd ~/Documents
git clone https://BorkStick:$GITPASS@lab.borkslash.com/borkstick/borknotes.git
mkdir ~/PROJECTS
cd ~/PROJECTS
git clone https://BorkStick:$GITPASS@lab.borkslash.com/borkstick/server-stuff.git
git clone https://BorkStick:$GITPASS@lab.borkslash.com/borkstick/anisble-playborks.git
}


#dracula theme for gnome terminal
draculaTheme() {
echo ""
echo "==================================="
echo " IT IS TIME TO SUCK SOME BLOOOOOOD "
echo "==================================="
echo ""
echo ""
cd /tmp
git clone https://github.com/GalaticStryder/gnome-terminal-colors-dracula
./gnome-terminal-colors-dracula/install.sh
}

jobDone() {
#clear
echo ""
echo "===================="
echo " Jobs Finished! "
echo "===================="
echo ""
echo ""
}

# Intro
intro() {
#clear
echo ""
echo "=================================================================="
echo " Welcome to the BorkSlash INITIAL SETUP SCRIPT FOR DESKTOP LINUX! "
echo "=================================================================="
echo ""
sleep 1
#clear
}

mainMenu() {
# Chooose what to install
# basic, min, full, manual, quit
#
#
PS3='Please enter your choice: '
options=("Basic" "Min" "Full" "Manual" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Basic")
            basic
            jobDone
            break
            ;;
        "Min")
            echo "you chose $opt"
            min
            upAndRunning
            jobDone
            break
            ;;
        "Full")
            echo "you chose choice $REPLY which is $opt"
            full
            upAndRunning
            jobDone
            break
            ;;
        "Manual")
            echo "you chose choice $REPLY which is $opt"
            full
            jobDone
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
}



#
# It starts here
#

intro
mainMenu

