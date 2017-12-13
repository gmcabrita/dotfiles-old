#!/bin/bash
set -e

ERLANG=$(curl -s https://api.github.com/repos/erlang/otp/releases/latest | jq -r ".tag_name" | sed -e "s/OTP-//");
ELIXIR=$(curl -s https://api.github.com/repos/elixir-lang/elixir/releases/latest | jq -r ".tag_name" | sed -e "s/v//");
GO=$(curl -s https://github.com/golang/go/releases | grep "release-branch" | head -1 | sed 's/.*] go//');
NODEJS=$(curl -s https://api.github.com/repos/nodejs/node/releases/latest | jq -r ".tag_name" | sed -e "s/v//");
TERRAFORM=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r ".tag_name" | sed -e "s/v//");
MINIKUBE=$(curl -s https://storage.googleapis.com/minikube/releases.json | jq -r ".[0].name" | sed -e "s/v//");
KUBECTL=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt | sed -e "s/v//");
KUBECFG=$(curl -s https://api.github.com/repos/ksonnet/kubecfg/releases/latest | jq -r ".tag_name" | sed -e "s/v//");

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.2.0
# shellcheck source=/dev/null
. "$HOME/.asdf/asdf.sh"

# erlang
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang
asdf install erlang "$ERLANG"
asdf global erlang "$ERLANG"

# elixir
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
asdf install elixir "$ELIXIR"
asdf global elixir "$ELIXIR"

# go
asdf plugin-add go https://github.com/kennyp/asdf-golang
asdf install go "$GO"
asdf global go "$GO"

# nodejs
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs "$NODEJS"
asdf global nodejs "$NODEJS"
npm -g install dockerlint

# terraform
asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git
asdf install terraform "$TERRAFORM"
asdf global terraform "$TERRAFORM"

# minikube
asdf plugin-add minikube https://github.com/alvarobp/asdf-minikube.git
asdf install minikube "$MINIKUBE"
asdf global minikube "$MINIKUBE"

# kubectl
asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
asdf install kubectl "$KUBECTL"
asdf global kubectl "$KUBECTL"

# kubecfg
asdf plugin-add kubecfg https://github.com/Banno/asdf-ksonnet.git
asdf install kubecfg "$KUBECFG"
asdf global kubecfg "$KUBECFG"
