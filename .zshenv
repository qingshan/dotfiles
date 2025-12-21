# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ! -o interactive && ! -o login && -s "$HOME/.zprofile" ]]; then
  export PATH="/usr/local/bin:$PATH"

  # homebrew
  if [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
  fi

  source $HOME/.zprofile
fi

# /etc/zprofile is sourced after ~/.zshenv for interactive shells
