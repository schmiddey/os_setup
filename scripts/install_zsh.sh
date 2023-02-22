#install script only for debian based distros and macos

#check os type and install zsh
if [ -f /etc/debian_version ]; then
    sudo apt install zsh -y
    #install wget
    sudo apt install curl -y
    #install tmux
    sudo apt install tmux -y
    #install git
    sudo apt install git -y
else
    exit 1
fi

#if on macos not needed 


#check if oh-my-zsh is installed
if [ -d ~/.oh-my-zsh ]; then
    echo "oh-my-zsh already installed"
else
    #install oh-my-zsh silent
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

fi




#install zsh-completions
#check if zsh-completions is installed
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    echo "zsh-completions already installed"
else
    #install zsh-completions
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
fi

#check if zsh-autosuggestions is installed
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    echo "zsh-autosuggestions already installed"
else
    #install zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi


#check if zsh-syntax-highlighting is installed
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    echo "zsh-syntax-highlighting already installed"
else
    #install zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi


#for now this repo must be in ~/.schmiddey/


#copy theme
cp ~/.schmiddey/os_setup/res/gallois_own.zsh-theme ~/.oh-my-zsh/themes/

### create .zshrc

#copy base .zshrc
cp ~/.schmiddey/os_setup/res/zshrc_base.txt ~/.zshrc_build
# user=$(whoami)
replace="export ZSH=\"/home/$USER/.oh-my-zsh\""
search="_insert_zsh_env_here_"
#replace line in .zshrc_build
if [[ $search != "" && $replace != "" ]]; then
  #use + as delimiter to avoid problems with / in paths
  sed -i "s+$search+$replace+" ~/.zshrc_build
fi

#if first argument is ros1 or ros2 then append zshrc_ros1/2.txt
# if [ "$1" = "ros1" ]; then
#     cat ~/.schmiddey/os_setup/res/zshrc_ros1.txt >> ~/.zshrc_build
#el
if [ "$1" = "ros2" ]; then
  cat ~/.schmiddey/os_setup/res/zshrc_ros2.txt >> ~/.zshrc_build

  #append command to source .zshrc_build
  echo "useros2 $2" >> ~/.zshrc_build
fi


#rename .zshrc to .zshrc_default
mv ~/.zshrc ~/.zshrc_default
#rename .zshrc_build to .zshrc
mv ~/.zshrc_build ~/.zshrc


