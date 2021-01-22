# !/bin/bash

red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }

# Ubuntu by default
cmd="apt-get"
install="install"
yes="-y"

os_bit=$(uname -a)
os=
user=$(whoami)

case $os_bit in
    *Ubuntu* | *Microsoft*)
    os="ubuntu"
    ;;
    *MANJARO*)
    os="manjaro"
    cmd="pacman -S"
    install=""
    yes="--noconfirm"
    ;;
    *)
    echo -e " Only supports Ubuntu and Manjaro" && exit 1
    ;;
esac

update()
{
    if [[ $os == "ubuntu" ]]; then
        apt-get update -y
    elif [[ $os == "manjaro" ]]; then
        pacman -Syy --noconfirm
    fi
    echo "----------------------------------------------------------------"
}

install_zsh()
{
    $cmd $install $yes zsh
    while :; do
        read -p "$(echo -e "(Would you like to install oh-my-zsh and zshrc?: [${magenta}Y/N$none]):") " install_ohmyzsh
        if [[ -z "$install_ohmyzsh"  ]]; then
            error
        else
            if [[ "$install_ohmyzsh" == [Yy] ]]; then
                su -c "wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O ohmyzsh.sh" $user
                su -c "sh ohmyzsh.sh --unattended" $user
                su -c "rm ohmyzsh.sh" $user
                su -c "cp ./zsh/zshrc ~/.zshrc" $user
                su -c "sed 's/USER/$user/' ~/.zshrc > ~/.zshrc" $user
                echo -e "Installation complete"
                echo -e "Use chsh -s zsh or chsh -s /bin/zsh to change the default shell"
                echo
                break
            elif [[ "$install_ohmyzsh" == [Nn] ]]; then
                echo -e "Skipped"
                break
            else
                error
            fi
        fi
    done
    echo "----------------------------------------------------------------"
}

install_vim()
{
    $cmd $install $yes vim
    while :; do
        read -p "$(echo -e "(Would you like to install .vimrc and vim plug?: [${magenta}Y/N$none]):") " install_vimrc
        if [[ -z "$install_vimrc"  ]]; then
            error
        else
            if [[ "$install_vimrc" == [Yy] ]]; then
                install_nodejs
                install_pip
                python3 -m pip install pynvim
                su -c "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" $user
                su -c "cp ./vim/vimrc ~/.vimrc" $user
                su -c "vim +PlugInstall +qall" $user
                echo -e "Installation complete"
                echo -e "At the first run, use :PlugInstall to install all plugins"
                echo
                break
            elif [[ "$install_vimrc" == [Nn] ]]; then
                echo -e "Skipped"
                break
            else
                error
            fi
        fi
    done
    echo "----------------------------------------------------------------"
}

install_ripgrep()
{
    $cmd $install $yes ripgrep
    echo "----------------------------------------------------------------"
}

install_fzf()
{
    $cmd $install $yes fzf
    echo "----------------------------------------------------------------"
}

install_tmux()
{
    $cmd $install $yes tmux
    while :; do
        read -p "$(echo -e "(Would you like to install tmux plugin and .tmux.conf?: [${magenta}Y/N$none]):") " install_tpm
        if [[ -z "$install_tpm"  ]]; then
            error
        else
            if [[ "$install_tpm" == [Yy] ]]; then
                su -c "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm" $user
                su -c "cp ./tmux/tmux.conf ~/.tmux.conf" $user
                echo -e "Installation complete"
                echo -e "At the first run, use prefix + I to install all plugins"
                echo
                break
            elif [[ "$install_tpm" == [Nn] ]]; then
                echo -e "Skipped"
                break
            else
                error
            fi
        fi
    done
    echo "----------------------------------------------------------------"
}

install_pip()
{
    $cmd $install $yes python
    su -c "wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py" $user
    echo "Install the pip for root"
    python3 get-pip.py
    su -c "rm get-pip.py" $user
    echo "----------------------------------------------------------------"
}

install_nodejs()
{
    $cmd $install $yes nodejs
    echo "----------------------------------------------------------------"
}

install_all()
{
    install_zsh
    install_vim
    install_ripgrep
    install_fzf
    install_tmux
    install_pip
    install_nodejs
}

echo ".............. Tools Setup ................."
echo
echo
echo

if [[ $user != "root" ]]; then
    echo "Please use sudo to run the script, aborted"
    exit
fi

while :; do
    read -p "$(echo -e "(Would you like to configure setting for user instead of root user?: [${magenta}Y/N$none]):") " change_user
    if [[ -z "$change_user"  ]]; then
        error
    else
        if [[ "$change_user" == [Yy] ]]; then
            read -p "$(echo -e "Your user name:") " username_input
            user=$username_input
            break
        elif [[ "$change_user" == [Nn] ]]; then
            user=root
            break
        else
            error
        fi
    fi
done

echo "Apps will be installed for root user and configuration will be for $user"

while :; do
    read -p "$(echo -e "(Would you like to update first: [${magenta}Y/N$none]):") " update_repo
    if [[ -z "$update_repo"  ]]; then
        error
    else
        if [[ "$update_repo" == [Yy] ]]; then
            update
            echo -e "Start updating"
            echo "----------------------------------------------------------------"
            echo
            break
        elif [[ "$update_repo" == [Nn] ]]; then
            break
        else
            error
        fi
    fi
done

while :; do
    echo
    echo " 0. Install all"
    echo " 1. Install zsh"
    echo " 2. Install vim"
    echo " 3. Install ripgrep"
    echo " 4. Install fzf"
    echo " 5. Install tmux"
    echo " 6. Install pip"
    echo
    read -p "$(echo -e "Choose [${magenta}0-5$none]:")" choose
    case $choose in
        0)
        install_all
        break
        ;;
        1)
        install_zsh
        break
        ;;
        2)
        install_vim
        break
        ;;
        3)
        install_ripgrep
        break
        ;;
        4)
        install_fzf
        break
        ;;
        5)
        install_tmux
        break
        ;;
        6)
        install_pip
        break
        ;;
        *)
        error
        ;;
    esac
done

