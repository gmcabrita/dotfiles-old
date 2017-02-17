#!/bin/bash
set -e

# Rust
read -rp "Do you want to install Rust? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
	rustup install nightly
	rustup component add rust-src
	cargo install racer
	cargo install rustfmt
	cargo install ripgrep
	rustup run nightly cargo install clippy
fi;
