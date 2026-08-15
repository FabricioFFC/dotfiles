#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Homebrew"
if ! command -v brew > /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "==> Installing packages from Brewfile"
brew bundle --file="$DOTFILES/Brewfile"

echo "==> oh-my-zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

echo "==> Linking dotfiles"
link() {
  ln -sfn "$DOTFILES/$1" "$HOME/$2"
  echo "  ~/$2 -> $1"
}

link zprofile .zprofile
link zshrc .zshrc
link aliases .aliases
link gitconfig .gitconfig
link gitignore .gitignore
link gitmessage .gitmessage
link gemrc .gemrc

echo "==> Node via mise"
mise use --global node@latest

echo "Done. Restart your terminal (or run: exec zsh)"
