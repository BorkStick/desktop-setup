#!/bin/bash
# Bash Menu Script Example


# autokey-gtk vim i3 rofi htop tmux ffmpeg gdebi build-essential ffmpeg filezilla git curl hexchat gparted cmatrix exfat-fuse exfat-utils 
# dconf-cli software-properties-common openssh-server atom ranger obs-studio google-chrome-stable enpass vlc virtualbox gnome-tweaks vagrant 
# libcanberra-gtk0 libcanberra-gtk-module libgnome-keyring-common libgnome-keyring-dev

MinAppList="vim git build-essential software-properties-common openssh-server exfat-fuse exfat-utils htop "
BasicAppList="$MinAppList cmatrix ffmpeg tmux copyq shutter libcanberra-gtk0 libcanberra-gtk-module rofi code google-chrome-stable filezilla ranger gnome-tweaks vlc"
FullAppList="$BasicAppList hexchat gparted virtualbox vagrant ansible nodejs npm" 
ManualAppList=""

# Functions

# basic
# 
#
basic() {
    #clear
    start
    sudo apt install -y $BasicAppList
    #dotfiles
    
}


# min
#
# vim tmux htop git
min() {
    #clear
    start
    dotfiles
    #sudo apt install -y $MinAppList
    
}


# full
#
#
full(){
    clear
    start
    sudo apt install -y $FullAppList
    dotfiles
    draculaTheme
    ytdlInstall
    vscodePlugins
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
code --install-extension abusaidm.html-snippets
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension dbaeumer.vscode-eslint
code --install-extension ecmel.vscode-html-css
code --install-extension formulahendry.auto-close-tag
code --install-extension formulahendry.auto-complete-tag
code --install-extension formulahendry.auto-rename-tag
code --install-extension HookyQR.beautify
code --install-extension ionutvmi.path-autocomplete
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension octref.vetur
code --install-extension PKief.material-icon-theme
code --install-extension ritwickdey.LiveServer
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension wayou.vscode-todo-highlight
code --install-extension yzhang.markdown-all-in-one

# theme
code --install-extension dracula-theme.theme-dracula
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
git clone http://lab.borkslash.com/BorkStick/dotfiles.git ~/dotfiles

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
            jobDone
            break
            ;;
        "Full")
            echo "you chose choice $REPLY which is $opt"
            full
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

