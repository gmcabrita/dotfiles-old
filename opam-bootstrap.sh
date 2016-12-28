#!/bin/sh
OCAML_VERSION=4.04.0

opam init
eval "$(opam config env)"
opam switch $OCAML_VERSION
opam reinstall ocamlfind camlp4
opam install core utop async yojson core_extended core_bench cohttp async_graphics cryptokit menhir async_extended bin_prot jbuilder ppx_driver async_ssl core_kernel sexplib async_kernel base ppx_let ppx_expect async_rpc_kernel core_profiler incremental stdio rpc_parallel async_parallel async_find
