_teleport-command()
{
	local opts
	local cur
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}

	opts=""

	# HISTORY COMPLETION
	while read -r i; do
		opts="$opts $(basename "$i")"
	done < ~/.tp_history

	# CURRENT DIR COMPLETION
	if [ -z "$cur" ]; then
		cdir="."
	elif [[ "${cur:${#cur} - 1}" == '/' ]]; then
		cdir="$cur"
	else
		cdir=$(command dirname "${cur}")
	fi

	for i in $(command ls "$cdir" 2>/dev/null);  do
		opts="$opts $(basename "$i")"
	done

	COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
	return 0
}

_teleportalias-command()
{
	local opts
	local cur
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}

	opts=""

	# ALIAS COMPLETION
	while read -r i; do
		opts="$opts ${i//:*/}"
	done < ~/.tp_aliases

	COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
	return 0
}

complete -o default -F _teleport-command tp
complete -o default -F _teleportalias-command tpa
