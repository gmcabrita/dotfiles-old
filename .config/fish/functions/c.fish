function c
    if test -n "$argv"
        if test -f $argv
            cd (dirname $argv)
        else
            cd $argv
        end
    else
        cd
    end
end
