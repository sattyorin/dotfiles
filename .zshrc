# zplug (zsh plugin manager)
export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

# locale setting
export LANG=en_US.UTF-8

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "marzocchi/zsh-notify"

zplug load



zplug "b-ryan/powerline-shell"

function powerline_precmd() {
PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
for s in ${precmd_functions[@]}; do
if [ "$s" = "powerline_precmd" ]; then
return
fi
done
precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
install_powerline_precmd
fi



# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt no_share_history

# peco history
function peco-history-selection() {
BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
CURSOR=$#BUFFER
zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# peco cdr
function peco-cdr () {
local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
if [ -n "$selected_dir" ]; then
BUFFER="cd ${selected_dir}"
zle accept-line
fi
}
zle -N peco-cdr
bindkey '^E' peco-cdr 

# pyenv
if [ -d "/home/${USERNAME}/.pyenv" ]; then
export PYENV_ROOT="/home/${USERNAME}/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
fi
# ~pyenv

source /opt/ros/noetic/setup.zsh
alias cm='catkin_make'
alias python='python3'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias xargs='xargs '
function find_name(){find -name '*'$1}
alias f='find_name'
function xargs_grep(){xargs grep -r $1}
alias xg='xargs_grep'
# ex.) f py |xg 10

export MUJOCO_PY_MJKEY_PATH=~/.mujoco/mjkey.txt
export MUJOCO_PY_MJPRO_PATH=~/.mujoco/mjpro131
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/${USERNAME}/.mujoco/mjpro131/bin
export MUJOCO_PY_MJPRO_PATH=~/.mujoco/mujoco-2.1.1
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/${USERNAME}/.mujoco/mujoco-2.1.1/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/${USERNAME}/.mujoco/mujoco200/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/${USERNAME}/.mujoco/mujoco210/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.5/targets/x86_64-linux/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64
alias MJPL='LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libGLEW.so:/usr/lib/nvidia-367/libGL.so' #pddm
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libGLEW.so:/usr/lib/x86_64-linux-gnu/libGL.so.1
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia

export MUJOCO_PY_MJPRO_PATH=~/.mujoco/mujoco210
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/targets/x86_64-linux/lib
# export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"


alias cdp='cd ~/pfrobotics/catkin_ws && source devel/setup.zsh'

export PATH="$HOME/.poetry/bin:$PATH"

# export ROS_MASTER_URI="http://172.18.209.171:11311"
# export ROS_IP="172.18.209.198"
export ROS_MASTER_URI="http://localhost:11311"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/sattyorin/google-cloud-sdk/path.zsh.inc' ]; then . '/home/sattyorin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/sattyorin/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/sattyorin/google-cloud-sdk/completion.zsh.inc'; fi
