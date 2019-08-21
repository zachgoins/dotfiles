#!/bin/bash


install_two_line_bash() {
	echo '' >> .bashrc
	echo 'RESET="\[\033[0m\]"' >> .bashrc
	echo 'RED="\[\033[0;31m\]"' >> .bashrc
	echo 'GREEN="\[\033[01;32m\]"' >> .bashrc
	echo 'BLUE="\[\033[01;34m\]"' >> .bashrc
	echo 'YELLOW="\[\033[0;33m\]" ' >> .bashrc
	echo 'PS_LINE=`printf -- '- %.0s' {1..200}`' >> .bashrc
	echo 'function parse_git_branch {' >> .bashrc
	echo '  PS_BRANCH=''' >> .bashrc
	echo '  PS_FILL=${PS_LINE:0:$COLUMNS}' >> .bashrc
	echo '  if [ -d .svn ]; then' >> .bashrc
	echo '    PS_BRANCH="(svn r$(svn info|awk '/Revision/{print $2}'))"' >> .bashrc
	echo '    return' >> .bashrc
	echo '  elif [ -f _FOSSIL_ -o -f .fslckout ]; then' >> .bashrc
	echo '    PS_BRANCH="(fossil $(fossil status|awk '/tags/{print $2}')) "' >> .bashrc
	echo '    return' >> .bashrc
	echo '  fi' >> .bashrc
	echo '  ref=$(git symbolic-ref HEAD 2> /dev/null) || return' >> .bashrc
	echo '  PS_BRANCH="(git ${ref#refs/heads/}) "' >> .bashrc
	echo '}' >> .bashrc
	echo 'PROMPT_COMMAND=parse_git_branch' >> .bashrc
	echo 'PS_INFO="$GREEN\u@\h$RESET:$BLUE\w"' >> .bashrc
	echo 'PS_GIT="$YELLOW\$PS_BRANCH"' >> .bashrc
	echo 'PS_TIME="\[\033[\$((COLUMNS-10))G\] $RED[\t]"' >> .bashrc
	echo 'export PS1="\${PS_FILL}\[\033[0G\]${PS_INFO} ${PS_GIT}${PS_TIME}\n${RESET}\$ "' >> .bashrc
}

set_tmux_conf() {
	echo '# Change prefix binding' >> .tmux.conf
	echo 'unbind C-b' >> .tmux.conf
	echo 'set -g prefix C-a' >> .tmux.conf
	echo 'bind C-a send-prefix' >> .tmux.conf
	echo '' >> .tmux.conf
	echo '# Make the history huge' >> .tmux.conf
	echo 'set -g history-limit 100000' >> .tmux.conf
	echo '' >> .tmux.conf
	echo 'set -g default-terminal "screen-256color"' >> .tmux.conf
	echo 'set-option -g status-bg           colour235 # dark gray' >> .tmux.conf
	echo 'set-option -g status-fg           colour231 # white' >> .tmux.conf
	echo 'set-option -g status-left-length  0' >> .tmux.conf
	echo 'set-option -g status-right-length 0' >> .tmux.conf
	echo 'set-option -g status-interval     0' >> .tmux.conf
	echo 'set-option -g bell-action         any' >> .tmux.conf
	echo 'set-option -g default-terminal    'screen-256color'' >> .tmux.conf
	echo '' >> .tmux.conf
	echo 'set-window-option -g mode-keys                    vi' >> .tmux.conf
	echo 'set-window-option -g window-status-format         " #W "' >> .tmux.conf
	echo 'set-window-option -g window-status-current-format " #W "' >> .tmux.conf
	echo 'set-window-option -g window-status-bg             colour239' >> .tmux.conf
	echo 'set-window-option -g window-status-current-bg     blue' >> .tmux.conf
	echo '#set-window-option -g window-status-alert-attr     none' >> .tmux.conf
	echo '#set-window-option -g window-status-alert-bg       red' >> .tmux.conf
	echo '#set-window-option -g window-status-alert-fg       colour231' >> .tmux.conf
	echo '' >> .tmux.conf
	echo 'bind C-b last-window' >> .tmux.conf
	echo 'bind j select-pane -t:.+' >> .tmux.conf
	echo 'bind k select-pane -t:.-' >> .tmux.conf
	echo '' >> .tmux.conf
	echo '# Enable mouse support (works in 16.04)' >> .tmux.conf
	echo 'set-option -g mouse on' >> .tmux.conf
	echo '' >> .tmux.conf
	echo 'set-window-option -g mode-keys vi' >> .tmux.conf
	echo '' >> .tmux.conf
	echo '# Start windows and panes at 1, not 0' >> .tmux.conf
	echo 'set -g base-index 1' >> .tmux.conf
	echo 'setw -g pane-base-index 1' >> .tmux.conf
	echo '' >> .tmux.conf
	echo 'bind-key -T copy-mode-vi 'v' send -X begin-selection' >> .tmux.conf
	echo 'bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel' >> .tmux.conf
}

install_bash_aliases() {
	echo '' >> .bashrc
	echo 'copy () {' >> .bashrc
    echo '	xclip -sel clip < $1' >> .bashrc
	echo '}' >> .bashrc
}


wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"

sudo apt install -y sublime-text
sudo apt install -y git 
sudo apt install -y vim
sudo apt install -y htop
sudo apt install -y tmux
sudo apt install -y net-tools
sudo apt install -y openssh-server
sudo apt install -y feh

install_two_line_bash
install_bash_aliases
set_tmux_conf
