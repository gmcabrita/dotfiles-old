#!/bin/bash

# shellcheck disable=SC1090
[ -n "$PS1" ] && source ~/.bash_profile;

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi
