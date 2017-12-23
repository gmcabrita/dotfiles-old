#!/bin/bash
set -e

# Rust
curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
# shellcheck disable=SC1090
source ~/.bash_profile || true
rustup install nightly
rustup component add rls-preview
rustup component add rust-analysis
rustup component add rust-src

# Useful packages
cargo install racer --force
cargo install rustsym --force
cargo install cargo-check --force
cargo install cargo-release --force
cargo install ripgrep --force
cargo install cargo-fuzz --force
rustup run nightly cargo install clippy --force
