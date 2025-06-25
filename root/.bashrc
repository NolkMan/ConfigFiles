#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# export PATH=$HOME/.local/bin:$PATH

alias ls='ls --color=auto'
alias grep='grep --color=auto'

function make_ps1(){
	#local white='\e[0;37m' # this is true white
	local white='\e[0m' # this is actually a reset
	#local purple='\e[0;35m'
	local purple='\e[1;91m'

	local save='\e[s'
	local restore='\e[u'

	# save and move to the right (-3)
	local ps1=${save}'\e[${COLUMNS}C\e[3D'
	# write 4 character on the right of the line
	ps1=${ps1}${purple}'--=='
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

LS_COLORS=$LS_COLORS:'di=1;91:'
export LS_COLORS

set -o vi

