# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal macOS dotfiles. There is no build, lint, or test suite — the only executable is `./install.sh`, which is idempotent: it installs Homebrew if missing, runs `brew bundle --file=Brewfile`, installs oh-my-zsh (with `--keep-zshrc`), symlinks configs, and sets up Node via mise. Re-running it is safe.

## How files map to $HOME

Files live at the repo root *without* the leading dot; `install.sh` symlinks them into place with `ln -sfn` (e.g. `zshrc` → `~/.zshrc`, `gitconfig` → `~/.gitconfig`).

Adding a new dotfile requires two changes: create the file at the repo root (no dot prefix) and add a `link` line in `install.sh`. Update the Layout section in `README.md` too.

## Shell startup chain

`zprofile` (brew shellenv) → `zshrc`, which loads in order: oh-my-zsh (theme is overridden by starship), fzf keybindings, `~/.aliases`, starship prompt, mise. Shell aliases belong in `aliases`, not `zshrc`.

## Packages

`Brewfile` is the single manifest for CLI tools, casks, and fonts. To add software, add it there rather than documenting a manual `brew install` step; apply with `brew bundle --file=Brewfile`.
