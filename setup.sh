#!/usr/bin/env bash
set -euo pipefail

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed, skipping."
fi

# external plugins
for plugin in \
  https://github.com/zsh-users/zsh-autosuggestions \
  https://github.com/johanhaleby/kubetail; do
  dest="$HOME/.oh-my-zsh/custom/plugins/$(basename "$plugin")"
  [ -d "$dest" ] && echo "$(basename "$plugin") already installed, skipping." || git clone --depth=1 "$plugin" "$dest"
done

# custom plugins and themes
for addon in "$PWD"/custom/*/*; do
  dest="$HOME/.oh-my-zsh/custom/${addon#"$PWD"/custom/}"
  [ -L "$dest" ] && echo "$(basename "$addon") already linked, skipping." || ln -s "$addon" "$dest"
done

# version managers
for repo in \
  https://github.com/go-nv/goenv \
  https://github.com/pyenv/pyenv \
  https://github.com/rbenv/rbenv; do
  dest="$HOME/.$(basename "$repo")"
  [ -d "$dest" ] && echo "$(basename "$repo") already installed, skipping." || git clone --depth=1 "$repo" "$dest"
done

# kubectl
[ -x "$HOME/.local/bin/kubectl" ] && echo "kubectl already installed, skipping." || {
  mkdir -p "$HOME/.local/bin"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  mv ./kubectl "$HOME/.local/bin/kubectl"
}

# .zshrc
[ -L "$HOME/.zshrc" ] && echo ".zshrc already linked, skipping." || ln -s "$PWD/.zshrc" "$HOME/.zshrc"

# .secret-file — sourced by .zshrc if present
[ -f "$HOME/.secret-file" ] && echo ".secret-file already exists, skipping." || touch "$HOME/.secret-file"

