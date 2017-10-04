#!/bin/bash
set -e

# Rust
read -rp "Do you want to install Rust? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
	# shellcheck disable=SC1090
	source ~/.bash_profile
	rustup install nightly
	rustup component add rls --toolchain nightly
	rustup component add rust-analysis --toolchain nightly
	rustup component add rust-src --toolchain nightly
	rustup component add rust-src
	cargo install racer --force
	cargo install rustsym --force
	cargo install rustfmt --force
	cargo install cargo-edit --force
	cargo install cargo-watch --force
	cargo install cargo-profiler --force
	cargo install cargo-modules --force
	cargo install cargo-outdated --force
	cargo install cargo-benchcmp --force
	cargo install cargo-vendor --force
	cargo install cargo-audit --force
	cargo install cargo-check --force
	cargo install cargo-safety --force
	cargo install cargo-update --force
	cargo install cargo-release --force
	cargo install cargo-count --force
	cargo install cargo-tree --force
	cargo install cargo-graph --force
	cargo install cargo-license --force
	cargo install ripgrep --force
	rustup run nightly cargo install cargo-fuzz --force
	rustup run nightly cargo install clippy --force
fi;
