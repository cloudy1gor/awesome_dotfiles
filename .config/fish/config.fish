# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
                           
# Autostart
if status is-login
    if test -z "$DISPLAY" -a "$(tty)" = /dev/tty1
        exec startx -- -keeptty
    end
end

set fish_greeting ""

# theme
set -g theme_color_scheme terminal-light
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_nerd_fonts no
set -g theme_powerline_fonts yes
set -g fish_prompt_pwd_dir_length 0

# aliases"
alias ls "ls --color=auto -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git

alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias df="df -h"
alias rm="rm -ir"
alias c="clear"
alias cd..="cd .."
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias :q='exit'

# pomodoro timer
alias work="timer 30m && notify-send \
'Pomodoro' 'Work Timer is up! Take a Break 😊' -i \
~/.cache/pomo/pomo-tomato.png -t 30000 -w -A 'Dismiss'\
& disown;"

alias rest="timer 10m && notify-send \
'Pomodoro' 'Break is over! Get back to work 😬' -i \
~/.cache/pomo/pomo-tomato.png -t 30000 -w -A 'Dismiss'\
& disown;"

alias x="startx"
alias p="command yay"
alias pu="command yay -Syyu --answerclean yes --rebuildall --noconfirm"

#color scheme
set -U fish_color_param green
set -U fish_color_command brblue
set -U fish_color_operator green
set -U SPACEFISH_DIR_COLOR green
set -gx EDITOR nvim
set TERM "kitty"

# PATH
set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.bin $PATH

set -x FZF_DEFAULT_OPTS '-e --prompt="הּ " --preview "bat --color=always {1} --theme=ansi" --layout=reverse --height=50% --info=inline --border --margin=1 --padding=1'
set FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set FZF_ALT_C_COMMAND "fd --ignore-case --hidden -t d"

set SPACEFISH_PROMPT_ORDER time user dir host git package node docker ruby golang php rust haskell julia aws conda pyenv kubecontext exec_time line_sep battery jobs exit_code char

set -x -g PIPENV_VENV_IN_PROJECT 1
set -x -g PIPENV_TIMEOUT 3600

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Shell prompt
starship init fish | source

if status --is-interactive
   neofetch
end

export TERM=xterm-kitty

