# dotfiles

macOS setup: Homebrew, oh-my-zsh + starship prompt, mise, ghostty, and shell/git configs.

## Install

```sh
git clone git@github.com:FabricioFFC/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./install.sh
```

The script installs Homebrew (if missing), everything in the `Brewfile`, oh-my-zsh, then symlinks the configs into `$HOME`.

## Manual steps

- Generate an SSH key and add it to GitHub:

  ```sh
  ssh-keygen -t rsa
  pbcopy < ~/.ssh/id_rsa.pub
  ```

- Install manually (not on Homebrew): Xcode (App Store), [Dia](https://www.diabrowser.com/).

## Layout

- `zshrc` / `zprofile` / `aliases` — shell config
- `gitconfig` / `gitignore` / `gitmessage` — git config
- `gemrc` — ruby gems config
- `Brewfile` — CLI tools and apps
