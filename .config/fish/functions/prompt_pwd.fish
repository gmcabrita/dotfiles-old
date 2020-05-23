function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
    printf "%s" (echo $PWD|sed -e "s|^$HOME|~|")
end
