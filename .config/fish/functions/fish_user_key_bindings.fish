function fish_user_key_bindings
  # ctrl-del
  bind \e\[3\;5~ kill-word

  # ctrl-backspace
  bind \cH backward-kill-word

  # ctrl+home/end
  bind \e\[1\;5H beginning-of-line
  bind \e\[1\;5F end-of-line
end
