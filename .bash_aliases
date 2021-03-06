#-------------------------------------------------------------
# Useful functions
#-------------------------------------------------------------
function command_exists () { hash "$1" 2>&- ; }


#-------------------------------------------------------------
# The 'ls' family
#-------------------------------------------------------------
if [[ -z $LS ]] ; then
	LS=ls
fi

alias ls=$LS
alias l.="$LS -d .*"   # hidden files only
alias ll="$LS -l"      # long listing
alias la="$LS -lA"     # show hidden files
alias lk="$LS -lSr"    # sort by size, biggest last
alias lc="$LS -ltrc"   # sort by and show change time, most recent last
alias lu="$LS -ltru"   # sort by and show access time, most recent last
alias lt="$LS -ltr"    # sort by date, most recent last
alias lr="$LS -lR"     # recursive ls
alias tree='tree -Csh' # nice alternative to 'recursive ls'


#-------------------------------------------------------------
# The 'cd' family
#-------------------------------------------------------------
alias cd..='cd ..'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias ..7='cd ../../../../../../..'
alias ..8='cd ../../../../../../../..'
alias ..9='cd ../../../../../../../../..'

alias q='cd ..; ls'
alias d='dirs -v'
alias pu=pushd
alias po=popd
alias cwd=pwd


#-------------------------------------------------------------
# The 'awk' family
#-------------------------------------------------------------
alias awk1="awk '{print \$1}'"
alias awk2="awk '{print \$2}'"
alias awk3="awk '{print \$3}'"
alias awk4="awk '{print \$4}'"
alias awk5="awk '{print \$5}'"
alias awk6="awk '{print \$6}'"
alias awk7="awk '{print \$7}'"
alias awk8="awk '{print \$8}'"
alias awk9="awk '{print \$9}'"


#-------------------------------------------------------------
# colordiff
#-------------------------------------------------------------
if command_exists colordiff ; then
	alias diff=colordiff
fi


#-------------------------------------------------------------
# The 'find' family
#-------------------------------------------------------------
function f()  { find . -iname '*'$*'*' ; }
function fd() { find . -type d -iname '*'$*'*' ; }
function ff() { find . -type f -iname '*'$*'*' ; }


#-------------------------------------------------------------
# The 'git' family
#-------------------------------------------------------------
if command_exists git ; then
	if command_exists hub; then
		alias git=hub
	fi

	alias g='git'
	alias gap='git add -p'
	alias gbr='git branch'
	alias gd='git diff'
	alias gdc='git diff --cached'
	alias grh='git reset HEAD'
	alias grs='git reset --soft HEAD~1'
	alias gs='git status'
	alias gsp='git stash -p'
	alias gwd='git wdiff'
	alias gwdc='git wdiff --cached'
fi


#-------------------------------------------------------------
# The 'hg' family
#-------------------------------------------------------------
if command_exists hg ; then
	alias hgd='hg diff --color=always | less -FRX'
fi


#-------------------------------------------------------------
# The 'mark' family
#-------------------------------------------------------------
export MARKPATH=$HOME/.marks
function j() { cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"; }
function jump() { cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"; }
function mark { mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"; }
function unmark { rm -i "$MARKPATH/$1"; }
function marks {
	ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}';
}

_completemarks() {
	local curw=${COMP_WORDS[COMP_CWORD]};
	local wordlist=$(gfind $MARKPATH -type l -printf "%f\n");
	COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"));
	return 0;
}

complete -F _completemarks jump unmark

#-------------------------------------------------------------
# The 'svn' family
#-------------------------------------------------------------
if command_exists svn ; then
	svn_diff='svn diff --diff-cmd diff -x -duN'
	if command_exists colordiff ; then
		alias sd="${svn_diff}bw | colordiff"
		alias sdw="${svn_diff} | colordiff"
	else
		alias sd="${svn_diff}bw"
		alias sdw="${svn_diff}"
	fi

	alias ss='svn status --ignore-externals | grep -v ^X'
	alias sse='svn status'
	alias si='svn info'
	alias sc='svn checkout'
	alias sm='svn commit'
fi


#-------------------------------------------------------------
# Miscellaneous
#-------------------------------------------------------------
alias rgrep='grep -r'

alias du='du -kh'
alias mkdir='mkdir -p'

alias h=history

alias path='echo -e ${PATH//:/\\n}'
alias cdpath='echo -e ${CDPATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias myip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d " " -f 2'


#-------------------------------------------------------------
# Environment dependent
#-------------------------------------------------------------
if command_exists irb ; then
	alias irb='irb -r irb/completion'
fi

# if command_exists phpunit ; then
# 	alias phpunit='php -d memory_limit=512M phpunit'
# fi

if command_exists rlwrap ; then
	alias telnet='rlwrap telnet'
fi
