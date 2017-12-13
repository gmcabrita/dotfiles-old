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
    rustup component add rls-preview
    rustup component add rust-analysis
    rustup component add rust-src
fi;

read -rp "Do you want to install some useful cargo packages? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cargo install racer --force
    cargo install rustsym --force
    cargo install rustfmt --force
    cargo install cargo-check --force
    cargo install cargo-release --force
    cargo install cargo-tree --force
    cargo install ripgrep --force
    cargo install cargo-fuzz --force
    rustup run nightly cargo install clippy --force
fi;
