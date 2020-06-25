####### Tools for setup #######
# Update date: 2020-06-25

echo "Checking Linux Distribution..."
# TODO check linux distribution and set the installer
INSTALLER="apt-get -y install"

################################################################################
echo "Installing build essentials..."
$INSTALLER build-essentials

################################################################################
# Install
################################################################################
echo "Installing zsh..."
# zsh
$INSTALLER zsh

## oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## zshrc setting
cp zsh/zshrc ~/.zshrc

################################################################################
echo "Installing tmux..."
# tmux
$INSTALLER tmux

hash git

if ! [ -x "$(command -v git)" ]; then
  echo "git is not installed, installing..."
  $INSTALLER git
fi

## tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp ./tmux/tmux.conf ./tmux/tmux.conf
# TODO let the plugin install the plugins in the config file
# otherwise we have to do the install manually after the launch

################################################################################
echo "Installing pip3..."
# pip3
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py


################################################################################
echo "Installing vim..."
# vim

# vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

## essentials
python3 -m pip install pynvim
python3 -m pip install jedi


################################################################################
echo "Installing useful tools..."
# vim
# useful tools
# #autojump
$INSTALLER autojump

# rg

# fzf

# cmake
$INSTALLER cmake

# clangd
$INSTALLER clangd

################################################################################
# post install
################################################################################

