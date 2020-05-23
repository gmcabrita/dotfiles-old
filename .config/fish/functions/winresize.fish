function winresize
    wmctrl -r $argv[1] -e 0,0,0,$argv[2],$argv[3]
end
