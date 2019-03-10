# Tab completion
require 'irb/completion'
IRB.conf[:USE_READLINE] = true

# Set default prompt
IRB.conf[:PROMPT_MODE] = :SIMPLE

# Keep history from old sessions
IRB.conf[:SAVE_HISTORY] = 1000

# Auto ident code
IRB.conf[:AUTO_INDENT] = true
