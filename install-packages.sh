#!/usr/bin/env bash

desired_mirrors=United_States
enabled_mirrors=$(
grep Country < /etc/pacman.d/mirrorlist | \
  grep -oP '\w+$' | \
  sort -u | \
  paste -sd,
)

if [ "$desired_mirrors" != "$enabled_mirrors" ]; then
  sudo rankmirrors -g -c "$desired_mirrors"
fi

ensure_gpg_key() {
  local server=$1
  local key_id=$2

  gpg --list-keys "$key_id" > /dev/null || \
    gpg --keyserver "$server" --recv-keys "$key_id"
}

# Dave Reisner, required for Cower a Pacaur dependency
ensure_gpg_key hkp://pgp.mit.edu 1EB2638FF56C0C53
# Thomas Dickey, required for ncurses5-compat-libs
ensure_gpg_key hkp://pgp.mit.edu 702353E0F7E48EDB

set -euo pipefail
IFS=$'\n\t'

arch_packages=(
autojump
aws-cli
bash
bash-completion
cloc
cmake
copyq
curl
dbeaver
dnsmasq
docker-compose
doctl-bin
git
git-lfs-bin
htop
imagemagick
jdk8-openjdk
libinput-gestures
nodejs
npm
oh-my-zsh-git
postgresql-libs
python
python-pip
python2
python2-boto
python2-pip
ruby
s3cmd
sqlite
terraform
tig
unzip
visual-studio-code
wget
xclip
yarn
zip
zsh
zsh-autosuggestions
zsh-completions
zsh-syntax-highlighting
)

python_packages=(
aws-shell
)

pacaur_install () {
  package=$1
  echo "Installing $package"
  set +e

  if pacaur -Qs "^$package$" > /dev/null; then
    return
  fi
  set -e
  pacaur -S --noconfirm --noedit "$package"
}

for package in "${arch_packages[@]}"; do
  pacaur_install "$package"
done

for package in "${python_packages[@]}"; do
  pip install --user --upgrade "$package"
done

for service in systemd-units/**/*.service; do
  unit_name=$(basename "$service")
  source=$(realpath "$service")
  target=/etc/systemd/system/$unit_name
  if [ -h "$target" ] && [ "$(readlink -f "$target")" = "$source" ]; then
    continue
  fi
  sudo ln -s "$source" "$target"
done

sudo usermod -aG docker "$USER"
sudo usermod -aG input "$USER"
sudo chsh "$USER" --shell /bin/zsh
