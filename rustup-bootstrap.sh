#!/bin/sh
set -e

curl https://sh.rustup.rs -sSf | sh
rustup install nightly
rustup component add rust-src
cargo install racer
cargo install rustfmt
rustup run nightly cargo install clippy