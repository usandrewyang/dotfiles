#! bash oh-my-bash.module
#------------------------------------------------------------------------------
# Note on copyright (2022-08-23): The aliases defined in this file seems to
# originally come from a blog post [1].  See also the comments in lib/base.sh.
#
# [1] Nathaniel Landau, "My Mac OSX Bash Profile",
#     https://natelandau.com/my-mac-osx-bash_profile/, 2013-07-02.
#
#------------------------------------------------------------------------------
#  Description:  This file holds all general BASH aliases
#
#  For your own benefit, we won't load all aliases in the general, we will
#  keep the very generic command here and enough for daily basis tasks.
#
#  If you are looking for the more sexier aliases, we suggest you take a look
#  into other core alias files which installed by default.
#
#------------------------------------------------------------------------------

#   -----------------------------
#   1.  MAKE TERMINAL BETTER
#   -----------------------------

# Determines the use of the option `-v' on the first call
# Ref. https://github.com/ohmybash/oh-my-bash/issues/351
function _omb_alias_general_cp_init {
  if (tmp=$(_omb_util_mktemp); trap 'rm -f "$tmp"{,.2}' EXIT; command cp -v "$tmp" "$tmp.2" &>/dev/null); then
    alias cp='cp -iv' && function _omb_alias_general_cp_init { command cp -iv "$@"; }
  else
    alias cp='cp -i' && function _omb_alias_general_cp_init { command cp -i "$@"; }
  fi &&
    _omb_alias_general_cp_init "$@"
}
function _omb_alias_general_mv_init {
  if (tmp=$(_omb_util_mktemp); trap 'rm -f "$tmp.2"' EXIT; command mv -v "$tmp" "$tmp.2" &>/dev/null); then
    alias mv='mv -iv' && function _omb_alias_general_mv_init { command mv -iv "$@"; }
  else
    alias mv='mv -i' && function _omb_alias_general_mv_init { command mv -i "$@"; }
  fi &&
    _omb_alias_general_mv_init "$@"
}
function _omb_alias_general_mkdir_init {
  if command mkdir -pv . &>/dev/null; then
    alias mkdir='mkdir -pv' && function _omb_alias_general_mkdir_init { command mkdir -pv "$@"; }
  else
    alias mkdir='mkdir -p' && function _omb_alias_general_mkdir_init { command mkdir -p "$@"; }
  fi &&
    _omb_alias_general_mkdir_init "$@"
}

alias cp='_omb_alias_general_cp_init'       # Preferred 'cp' implementation
alias mv='_omb_alias_general_mv_init'       # Preferred 'mv' implementation
alias mkdir='_omb_alias_general_mkdir_init' # Preferred 'mkdir' implementation
# alias ll='ls -lAFh'                         # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias nano='nano -W'                        # Preferred 'nano' implementation
alias wget='wget -c'                        # Preferred 'wget' implementation (resume download)
alias c='clear'                             # c:            Clear terminal display
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias fix_term='echo -e "\033c"'            # fix_term:     Reset the conosle.  Similar to the reset command
alias cic='bind "set completion-ignore-case on"' # cic:          Make tab-completion case-insensitive
alias src='source ~/.bashrc'                # src:          Reload .bashrc file

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
alias ls='ls --color=auto'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
