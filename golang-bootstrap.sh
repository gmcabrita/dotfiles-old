#!/bin/bash
set -e

go get -u github.com/magefile/mage
go get -u github.com/google/codesearch/cmd/...
go get -u github.com/mitchellh/gox
go get -u github.com/dvyukov/go-fuzz/go-fuzz
go get -u github.com/dvyukov/go-fuzz/go-fuzz-build
go get -u github.com/nsf/gocode
go get -u github.com/tpng/gopkgs
go get -u github.com/fatih/gomodifytags
go get -u github.com/lukehoban/go-outline
go get -u github.com/newhook/go-symbols
go get -u golang.org/x/tools/cmd/guru
go get -u golang.org/x/tools/cmd/gorename
go get -u github.com/rogpeppe/godef
go get -u sourcegraph.com/sqs/goreturns
go get -u github.com/alecthomas/gometalinter
go get -u github.com/sourcegraph/go-langserver
go get -u github.com/golang/lint/golint
go get -u golang.org/x/tools/cmd/cover
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/uber/go-torch
go get -u github.com/tsliwowicz/go-wrk
go get -u github.com/tockins/realize
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
go get -u github.com/uber-common/cpustat
go get -u github.com/google/gops
go get -u github.com/rakyll/hey
go get -u github.com/peterbourgon/stats
go get -u github.com/golang/dep/cmd/dep

gometalinter --install
