#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$HOME/.local/bin:$PATH

alias ls='ls --color=auto'
alias grep='grep --color=auto'

function make_ps1(){
	#local white='\e[0;37m' # this is true white
	local white='\e[0m' # this is actually a reset
	#local purple='\e[0;35m'
	local purple='\e[1;95m'

	local save='\e[s'
	local restore='\e[u'

	# save and move to the right 
	local ps1=${save}'\e[${COLUMNS}C'
	# move number left
	ps1=${ps1}'\e[22D'
	# move half of the stuff to the right
	ps1=${ps1}'\e[$((15 - $(expr length + $(basename ${VIRTUAL_ENV:-/--}))))C'
	# write 4 character on the right of the line
	# Some art at the end of the line that becomes virtual env after 
	ps1=${ps1}${purple}'>='${white}'['${purple}
	ps1=${ps1}'$(basename ${VIRTUAL_ENV:-/--})'
	ps1=${ps1}${white}']'${purple}'=<'
	# restore and continues from the begging
	ps1=${ps1}${restore}
	ps1=${ps1}${purple}'=='${white}'['
	ps1=${ps1}${purple}'\u'${white}'@'${purple}'\h'
	ps1=${ps1}${white}']-['
	ps1=${ps1}${purple}'\w'
	ps1=${ps1}${white}']'
	ps1=${ps1}${white}'\n-\$ '
	echo "$ps1"
}

PS1=$(make_ps1)
unset make_ps1

LS_COLORS=$LS_COLORS:'di=1;95:'
export LS_COLORS

set -o vi
export MANPAGER='nvim +Man!'

alias envy='nvim -R "+set noreadonly" "+setlocal nomodifiable"'
alias nvim='nvim -p'

# PYENV Lines
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"

