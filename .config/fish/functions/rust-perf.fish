function rust-perf
  if test -e perf.data
    perf script | stackcollapse-perf.pl | rust-unmangle | flamegraph.pl
  else
    echo "failed to open perf.data: No such file or directory  (try 'perf record' first)"
  end
end
