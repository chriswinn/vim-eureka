#!/usr/bin/env bash
# vim-eureka installer

set -e
cat << EOF
# Show how to use this installer
function show_usage() {
  echo -e "\n$0 : Install vim-eureka"
  echo -e "Usage:\n$0 [arguments] \n"
  echo "Arguments:"
  echo "--help (-h): Display this help message"
  echo "--silent (-s): Install default settings without prompting for input";
  echo "--interactive (-i): Interactively choose plugins"
  echo "--no-modify-config (-n): Do not modify existing config file"
  exit 0;
}

EOF
cat << EOF
# Back up existing .vimrc file and create new from a template
function backup_new() {
	  test -w "$HOME/$CONFIG_FILE" &&
    cp -aL "$HOME/$CONFIG_FILE" "$HOME/$CONFIG_FILE.bak" &&
    echo -e "\033[0;32mYour original $CONFIG_FILE has been backed up to $CONFIG_FILE.bak\033[0m"
    sed "s|{{BASH_IT}}|$BASH_IT|" "$BASH_IT/template/bash_profile.template.bash" > "$HOME/$CONFIG_FILE"
    echo -e "\033[0;32mCopied the template $CONFIG_FILE into ~/$CONFIG_FILE, edit this file to customize bash-it\033[0m"
}

for param in "$@"; do
  shift
  case "$param" in
    "--help")               set -- "$@" "-h" ;;
    "--silent")             set -- "$@" "-s" ;;
    "--interactive")        set -- "$@" "-i" ;;
    "--no-modify-config")   set -- "$@" "-n" ;;
    *)                      set -- "$@" "$param"
  esac
done

OPTIND=1
while getopts "hsin" opt
do
  case "$opt" in
  "h") show_usage; exit 0 ;;
  "s") silent=true ;;
  "i") interactive=true ;;
  "n") no_modify_config=true ;;
  "?") show_usage >&2; exit 1 ;;
  esac
done
shift $(expr $OPTIND - 1)

if [[ $silent ]] && [[ $interactive ]]; then
  echo -e "\033[91mOptions --silent and --interactive are mutually exclusive. Please choose one or the other.\033[m"
  exit 1;
fi

EOF
cat << EOF
BASH_IT="$(cd "$(dirname "$0")" && pwd)"

EOF
cat << EOF
case $OSTYPE in
  darwin*)
    CONFIG_FILE=.bash_profile
    ;;
  *)
    CONFIG_FILE=.bashrc
    ;;
esac

EOF

cat << EOF
BACKUP_FILE=$CONFIG_FILE.bak
echo "Installing bash-it"
if ! [[ $silent ]] && ! [[ $no_modify_config ]]; then
  if [ -e "$HOME/$BACKUP_FILE" ]; then
    echo -e "\033[0;33mBackup file already exists. Make sure to backup your .bashrc before running this installation.\033[0m" >&2
    while ! [ $silent ];  do
      read -e -n 1 -r -p "Would you like to overwrite the existing backup? This will delete your existing backup file ($HOME/$BACKUP_FILE) [y/N] " RESP
      case $RESP in
      [yY])
        break
        ;;
      [nN]|"")
        echo -e "\033[91mInstallation aborted. Please come back soon!\033[m"
        exit 1
        ;;
      *)
        echo -e "\033[91mPlease choose y or n.\033[m"
        ;;
      esac
    done
  fi

  while ! [ $silent ]; do
    read -e -n 1 -r -p "Would you like to keep your $CONFIG_FILE and append bash-it templates at the end? [y/N] " choice
    case $choice in
    [yY])
      test -w "$HOME/$CONFIG_FILE" &&
      cp -aL "$HOME/$CONFIG_FILE" "$HOME/$CONFIG_FILE.bak" &&
      echo -e "\033[0;32mYour original $CONFIG_FILE has been backed up to $CONFIG_FILE.bak\033[0m"

      (sed "s|{{BASH_IT}}|$BASH_IT|" "$BASH_IT/template/bash_profile.template.bash" | tail -n +2) >> "$HOME/$CONFIG_FILE"
      echo -e "\033[0;32mBash-it template has been added to your $CONFIG_FILE\033[0m"
      break
      ;;
    [nN]|"")
      backup_new
      break
      ;;
    *)
      echo -e "\033[91mPlease choose y or n.\033[m"
      ;;
    esac
  done
elif [[ $silent ]] && ! [[ $no_modify_config ]]; then
  # backup/new by default
  backup_new
fi

EOF
cat << EOF
# Load dependencies for enabling components
source "$BASH_IT/lib/composure.bash"
source "$BASH_IT/lib/utilities.bash"
cite _about _param _example _group _author _version
source "$BASH_IT/lib/helpers.bash"

if [[ $interactive ]] && ! [[ $silent ]] ;
then
  for type in "aliases" "plugins" "completion"
  do
    echo -e "\033[0;32mEnabling $type\033[0m"
    load_some $type
  done
else
  echo ""
  echo -e "\033[0;32mEnabling reasonable defaults\033[0m"
  _enable-completion bash-it
  _enable-completion system
  _enable-plugin base
  _enable-plugin alias-completion
  _enable-alias general
fi

echo ""
echo -e "\033[0;32mInstallation finished successfully! Enjoy bash-it!\033[0m"
echo -e "\033[0;32mTo start using it, open a new tab or 'source "$HOME/$CONFIG_FILE"'.\033[0m"
echo ""
echo "To show the available aliases/completions/plugins, type one of the following:"
echo "  bash-it show aliases"
echo "  bash-it show completions"
echo "  bash-it show plugins"
echo ""
echo "To avoid issues and to keep your shell lean, please enable only features you really want to use."
echo "Enabling everything can lead to issues."
EOF
cat << EOF
echo -n "Symlinking dotfiles..."
#Symlink .bashrc, .bash_profile and .vimrc files
#ln -s $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
#mkdir $HOME/.vim/
#ln -s $HOME/.dotfiles/vim/plugin $HOME/.vim/plugin
#ln -s $HOME/.dotfiles/tmux/tmux.conf $HOME/.tmux.conf
#ln -s $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig
#ln -s $HOME/.dotfiles/gemrc $HOME/.gemrc
#ln -s $HOME/.dotfiles/javascript/jshintrc $HOME/.jshintrc
#ln -s $HOME/.dotfiles/ruby/rubocop.yml $HOME/.rubocop.yml
echo 'done!'

# Install Vim-Plug
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#vim +PlugInstall +q

# Install homebrew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#brew bundle
#brew linkapps vim

#gem install hub
#gem install rubocop-git
#brew install reattach-to-user-namespace # for  tmux-yank
#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#brew install node
#npm install -g eslint eslint-plugin-react eslint-plugin-jsx-a11y eslint-plugin-import eslint-config-airbnb

#echo "# Add machine-specific config here (this file and the local directory will be ignored by git)" > $HOME/.dotfiles/local/zshrc
#echo "Done installing! You can customize your local bash config by editing ~/.dotfiles/local/bashrc"
EOF
