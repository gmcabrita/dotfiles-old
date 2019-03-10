function todo
  grep \
    --exclude-dir=public \
    --exclude-dir=tmp \
    --exclude-dir=vendor \
    --exclude-dir=node_modules \
    --exclude=\*.log \
    --text \
    --color \
    -nRo 'TODO.*:.*\|FIXME.*:.*\|HACK.*:.*\|OPTIMIZE.*:.*' .
end