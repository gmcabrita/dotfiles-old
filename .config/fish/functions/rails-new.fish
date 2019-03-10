function rails-new
  rails new $argv --database=postgresql --skip-action-mailbox --skip-action-text --skip-action-cable --skip-active-storage --skip-coffee --webpack=stimulus
end
