#!/usr/bin/env bash
set -euo pipefail

image=${1:?image is required}
kind=${2:?server or desktop is required}
engine=${DOCKER:-docker}
name="dotfiles-test-$kind-$$"
test_dir=$(mktemp -d)
cleanup() {
  "$engine" stop "$name" >/dev/null 2>&1 || true
  rm -rf "$test_dir"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

case "$kind" in
  server|desktop) ;;
  *) echo "Unknown test kind: $kind" >&2; exit 2 ;;
esac

ssh-keygen -q -t ed25519 -C test@dotfiles -N "" -f "$test_dir/id_ed25519"
"$engine" run --name "$name" -d --rm "$image"
# Stream temporary keys through the engine so remote Docker contexts work too.
# Neither keys nor published ports are left on the daemon host.
"$engine" exec -i "$name" sh -c 'umask 077; cat > /tmp/dotfiles-test-key' < "$test_dir/id_ed25519"
"$engine" exec -i "$name" sh -c 'cat > /home/qingshan/.ssh/authorized_keys; chown qingshan:qingshan /home/qingshan/.ssh/authorized_keys; chmod 600 /home/qingshan/.ssh/authorized_keys' < "$test_dir/id_ed25519.pub"

ssh_args=(-q -i /tmp/dotfiles-test-key
  -o BatchMode=yes -o IdentitiesOnly=yes -o ConnectTimeout=2
  -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
  qingshan@127.0.0.1)
ready=false
for ((attempt = 0; attempt < 60; attempt++)); do
  if "$engine" exec "$name" ssh "${ssh_args[@]}" true; then
    ready=true
    break
  fi
  sleep 1
done
if [[ $ready != true ]]; then
  "$engine" logs "$name" >&2 || true
  echo "Container SSH did not become ready" >&2
  exit 1
fi

# A noninteractive SSH session deliberately enters a login shell to load PATH.
"$engine" exec "$name" ssh "${ssh_args[@]}" "bash -lc 'set -e; command -v fish tmux mise vim; rustc --version; node --version; python --version; dotfiles-doctor ~/.profile ~/.bashrc ~/.bash_profile ~/.zshrc ~/.zprofile ~/.config/mise/config.toml ~/.config/fish/config.fish ~/.config/lsd/config.yml ~/.config/starship.toml ~/.config/tmux/tmux.conf ~/.config/herdr/config.toml ~/.vimrc ~/.config/zk'"
if [[ $kind == desktop ]]; then
  "$engine" exec "$name" ssh "${ssh_args[@]}" "bash -lc 'set -e; command -v alacritty; dotfiles-doctor ~/.config/alacritty/alacritty.toml ~/.config/ghostty/config ~/.config/ideavim/ideavimrc'"
fi
