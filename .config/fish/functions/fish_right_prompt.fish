function fish_right_prompt
    if [ $CMD_DURATION -gt 1500 ]
        set duration = (math $CMD_DURATION/1000)
        set time_substr (date -d@$duration -u +%T)
        set miliseconds_substr (math (date -d@$duration -u +%-N)/1000000)
        set pretty_duration (printf "%s.%s" (echo $time_substr | sed -E "s/^(00:)+//") $miliseconds_substr)
        printf "%s" $pretty_duration
    end
end
