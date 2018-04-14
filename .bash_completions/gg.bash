# gg/ggg
_gg_complete-command()
{
    COMPREPLY=()
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
		# shellcheck disable=SC2044
    COMPREPLY=( $(compgen -W "$(for f in $(find "$GOPATH/src" -mindepth 1 -maxdepth 5 -type d -name "${cur}*" ! -name '.*' ! -path '*/.git/*' ! -path '*/test/*' ! -path '*/Godeps/*' ! -path '*/examples/*'); do echo "${f##*/}"; done)" --  "$cur") )
    return 0
}

complete -o default -F _gg_complete-command gg
complete -o default -F _gg_complete-command ggg
