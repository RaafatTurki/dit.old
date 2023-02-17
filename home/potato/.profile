#! /bin/sh

# function appendpath
#     set PATH $PATH:$1
# end

# appendpath $HOME/bin

# execute .bashrc if it exists
# [[ -f ~/.bashrc ]] && . ~/.bashrc


# prompt
PS1='\u \w | '
# eval "$(starship init bash)"

# finds binaries in $PATH
fbin() {
  echo `command -v $1`
}

append_path() {
  export PATH=$PATH:$1
}

prepend_path() {
  export PATH=$1:$PATH
}

# fail safes
export USER=${USER:-`whoami`}
export HOME=${HOME:-"/home/$USER"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME/.local/state/"}
append_path $HOME/.local/bin
# prepend_path $HOME/.local/bin_drop_ins/
# prepend_path $HOME/.local/bin/
append_path $HOME/.local/share/cargo/bin/
append_path $HOME/.local/share/go/bin/
export DOTS=~/dots
# more xdg support
export XDG_DATA_DIRS=/usr/local/share:/usr/share
# export XDG_DATA_DIRS=/usr/local/share:/usr/share:~/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share

# android
# append_path $ANDROID_HOME/cmdline-tools/tools/bin
# append_path $ANDROID_HOME/emulator
# append_path $ANDROID_HOME/platform-tools

# env
export SHELL=`fbin bash`
# export TERM="xterm-256color"
# export TERM="xst-256color"
export AUR_HELPER=`fbin paru`
export TERM_SHELL=`fbin fish`
export EDITOR=`fbin nvim`
export VISUAL=$EDITOR
export LESSPAGER="`fbin less` -R -S -X -e"
# export PAGER=`fbin nvim`
export PAGER="$LESSPAGER"
export MANPAGER="`fbin nvim` +Man!"
export PARU_PAGER="`fbin nvim` +Man!"
# export GIT_PAGER="`fbin nvim` +AnsiEsc"
# export GIT_PAGER=`fbin less`
# export GIT_PAGER=`fbin less -r`
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export USERSHARES_DIR="/var/lib/samba/usershares"
export USERSHARES_GROUP="sambashare"

export TERMINAL=`fbin st`
# export TERMINAL=`fbin kitty`
export FM=`fbin thunar`
export READER=`fbin zathura`
export BROWSER=`fbin firefox`
# export LAUNCHER="`fbin rofi` -show drun"
export LAUNCHER="`fbin jgmenu_run`"
export AUDIO_MIXER=`fbin pavucontrol`
export AUDIO_PLAYER=`fbin pragha`
export MUSIC_CLIENT="$TERMINAL -e `fbin ncmpcpp`"
export MUSIC_SERVER=`fbin mpd`
export SCREENSHOT=`fbin scrscn`
# export SXHKD_SHELL=$SHELL
export COLOR_PICKER=`fbin color-picker`
export SYSMON=`fbin btop`

# theming
export XCURSOR_THEME=capitaine-cursors-light
# export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=adwaita-dark

# telegram
# export QT_QPA_PLATFORMTHEME=gtk3
# export QT_QPA_PLATFORMTHEME=qt5ct
# export QT_QPA_PLATFORMTHEME=gtk2
# export TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY=1
# export TDESKTOP_DISABLE_DESKTOP_FILE_GENERATION=1

# java
export _JAVA_AWT_WM_NONREPARENTING=1

# unclutter home
export HISTFILE="$XDG_DATA_HOME/bash_history"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GTK_RC_FILES=$XDG_CONFIG_HOME/gtk-1.0/gtkrc
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
export PARALLEL_HOME=$XDG_CONFIG_HOME/parallel
export XINITRC=$XDG_CONFIG_HOME/x11/xinitrc
export ICEAUTHORITY=$XDG_CACHE_HOME/ICEauthority
# export GNUPGHOME=$XDG_CONFIG_HOME/gnupg
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export npm_config_prefix=$HOME/.local
export NODE_REPL_HISTORY=$XDG_CACHE_HOME/node_repl_history
export NPM_HOME=$XDG_DATA_HOME/npm
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
export GOPATH=$XDG_DATA_HOME/go
export ANDROID_HOME=/opt/android-sdk/
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
# export RUST_SRC_PATH=$RUSTUP_HOME/toolchains/nightly-$(uname -m)-unknown-linux-gnu/lib/rustlib/src/rust/src


# activate gtk3 no csd if available
GTK3_NO_CSD_SO=/usr/lib/libgtk3-nocsd.so.0
if [ -e $GTK3_NO_CSD_SO ]; then
  export GTK_CSD=0
  export LD_PRELOAD=$GTK3_NO_CSD_SO
fi

# Autostart tbsm on tty 1
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  startx $XINITRC
  # ./hypr.sh
else
  # setfont /usr/share/kbd/consolefonts/ter-v18n.psf.gz
  clear
  exec fish -C 'logo'
fi
