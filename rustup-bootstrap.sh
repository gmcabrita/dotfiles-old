#!/bin/bash
set -e

# Rust
read -rp "Do you want to install Rust? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
	source ~/.bash_profile
	rustup install nightly
	rustup component add rust-src
	cargo install racer
	cargo install rustsym
	cargo install rustfmt
	cargo install cargo-edit
	cargo install cargo-watch
	cargo install cargo-profiler
	cargo install cargo-modules
	cargo install cargo-outdated
	cargo install cargo-benchcmp
	cargo install cargo-audit
	cargo install cargo-check
	cargo install cargo-safety
	cargo install cargo-update
	cargo install cargo-vendor
	cargo install cargo-release
	cargo install cargo-count
	cargo install cargo-tree
	cargo install cargo-graph
	cargo install cargo-license
	cargo install ripgrep
	rustup run nightly cargo install cargo-fuzz
	rustup run nightly cargo install clippy
fi;
