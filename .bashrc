# ~/.bashrc
#
# http://www.gnu.org/software/bash/manual/bashref.html
# http://tldp.org/LDP/abs/html/index.html
# http://www.caliban.org/bash/
# http://www.shelldorado.com/scripts/categories.html
# http://www.dotfiles.org/

#-------------------------------------------------------------
# Useful functions
#-------------------------------------------------------------
function command_exists () { hash "$1" 2>&- ; }


#-------------------------------------------------------------
# Set PATH
#-------------------------------------------------------------
PATH=.:~/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
#CDPATH=.:~:~/Code


#-------------------------------------------------------------
# Determine if terminal supports color output
#-------------------------------------------------------------
case ${TERM} in
    ansi|xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix|screen)
        USE_COLOR=true ;;
    *)
        USE_COLOR=false ;;
esac


#-------------------------------------------------------------
# Command prompt appearance
#
# See https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#-------------------------------------------------------------
if [[ $USE_COLOR && $TERM ]] ; then
    # Define some colors (with transparent background)
    reset=$(tput -T ${TERM} sgr0)
    underline=$(tput -T ${TERM} sgr 0 1)
    black=$(tput -T ${TERM} setaf 0)
    red=$(tput -T ${TERM} setaf 1)
    green=$(tput -T ${TERM} setaf 2)
    yellow=$(tput -T ${TERM} setaf 3)
    blue=$(tput -T ${TERM} setaf 4)
    magenta=$(tput -T ${TERM} setaf 5)
    cyan=$(tput -T ${TERM} setaf 6)
    white=$(tput -T ${TERM} setaf 7)

    # set color prompt
    if [[ ${EUID} == 0 ]] ; then
        PS1='\[$red\]\u\[$reset\]@\[$blue\]\h\[$reset\]:\[$magenta\]\w\[$reset\]# '   # root
    else
        PS1='\[$blue\]\u\[$reset\]@\[$blue\]\h\[$reset\]:\[$magenta\]\w\[$reset\]\$ ' # non-root
    fi
else
    if [[ ${EUID} == 0 ]] ; then
        PS1='\u@\h:\w# '  # root
    else
        PS1='\u@\h:\w\$ ' # non-root
    fi
fi

if [[ -f ~/Code/powerline-shell/powerline-shell.py ]] ; then
    function _update_ps1() {
        export PS1="$(~/Code/powerline-shell/powerline-shell.py $? 2> /dev/null)"
    }

    export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

#-------------------------------------------------------------
# Colorful command output
#-------------------------------------------------------------
if [[ $USE_COLOR ]] ; then
    # Enable colored file listings
    if command_exists gdircolors ; then
        test -r $d && eval "$(gdircolors -b $d)" || eval "$(gdircolors -b)"
    elif command_exists dircolors ; then
        test -r $d && eval "$(dircolors -b $d)" || eval "$(dircolors -b)"
    fi

    # ls
    LS_COLORS=$LS_COLORS'ow=01;34;40:'
    LS_OPTIONS='--color'

    # grep
    export GREP_OPTIONS='--color=auto'
    export GREP_COLORS='mt=30;43:fn=35:ln=32:se=36'
fi


#-------------------------------------------------------------
# Tweak 'less'
#-------------------------------------------------------------
export LESS='-FiRMWX -z-2'
export LESSCHARSET='UTF-8'
if [[ -s "/usr/local/bin/lesspipe.sh" ]] ; then
    export LESSOPEN='|/usr/local/bin/lesspipe.sh %s 2>&-'
fi
export PAGER=less


#-------------------------------------------------------------
# Tweak 'ls'
#-------------------------------------------------------------
if command_exists gls ; then
    LS="$(type -p gls)"
else
    LS="/bin/ls"
fi
LS_OPTIONS="-Fh -T 0 $LS_OPTIONS"  # defined above
LS="$LS $LS_OPTIONS"
export LS


#-------------------------------------------------------------
# Aliases
#
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#-------------------------------------------------------------
if [[ -f ~/.bash_aliases ]] ; then
    . ~/.bash_aliases
fi


#-------------------------------------------------------------
# Test for an interactive shell. There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
#-------------------------------------------------------------
if [[ $- != *i*  || ! -t 0 && ! -p  /dev/stdin ]] ; then
    return  # Shell is non-interactive
fi


#-------------------------------------------------------------
# Command line editing
#-------------------------------------------------------------
shopt -s cmdhist histappend histreedit histverify
export HISTIGNORE="&:[ ]*:bg:fg:ls:ll:la:h"
export HISTFILESIZE=10000
export HISTSIZE=10000
export INPUTRC=~/.inputrc


#-------------------------------------------------------------
# Programmable completion features
#
# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#-------------------------------------------------------------
shopt -s cdspell        # Correct small typos when moving to another directory
shopt -s nocaseglob
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion

# A colon-separated list of suffixes to ignore when performing filename
# completion. A filename whose suffix matches one of the entries in FIGNORE is
# excluded from the list of matched filenames.
export FIGNORE=.svn

if command_exists brew ; then
    bp=$(brew --prefix)

    if [ -f $bp/etc/bash_completion ]; then
        source $bp/etc/bash_completion
    fi

    if [ -f $bp/Library/Contributions/brew_bash_completion.sh ] ; then
        source $bp/Library/Contributions/brew_bash_completion.sh
    fi

    if [ -f $bp/etc/bash_completion.d/vagrant ]; then
        source $bp/etc/bash_completion.d/vagrant
    fi
fi

if [ -f $HOME/.git-flow-completion/git-flow-completion.bash ]; then
    source $HOME/.git-flow-completion/git-flow-completion.bash
fi

# Only show dirs when completing dir-related commands
complete -d cd pushd rmdir


#-------------------------------------------------------------
# Miscellaneous settings
#-------------------------------------------------------------
ulimit -S -c 0    # Use soft limit and disable core dumps
set -o notify     # Notify of job termination immediately
set -o noclobber  # Disallow over-writing files via output redirection

export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts ...
export EDITOR=vim

# Un-hijack ^S
stty stop ''

# Generic colourizer
if [[ -f $bp/etc/grc.bashrc ]] ; then
    source $bp/etc/grc.bashrc
fi

# Go
if [[ -f $bp/bin/go ]] ; then
    export GOROOT=`brew --prefix go`
    export GOPATH=~/.go
    source `brew --prefix go`/etc/bash_completion.d/go-completion.bash
fi
