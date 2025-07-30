# [Dotfiles](https://github.com/blissful-group/.dotfiles)

The public (standard) configuration of blissful group dotfiles.

<a href="https://blissful.group">
  <img src="./public/favicon-32x32.png" alt="Logo" width="32" style="vertical-align: middle; margin-right: 8px;">
  <span>Blissful Group</span>
</a>

## Getting Started

### Dev containers

1. Add a `updateContentCommand.sh` script to your `.devcontainer.json`. This will inject the users .dotfiles or default to the repository `bootstrap`.

   ```json
   "updateContentCommand": "bash .devcontainer/scripts/updateContentCommand.sh",
   ```

   ```bash
   #!/bin/bash
   personal_bootstrap=$HOME/.dotfiles/bootstrap
   default_bootstrap=.devcontainer/config/bootstrap

   if [ -e "$personal_bootstrap" ]; then
     echo "Found and executing existing dotfiles bootstrap"
     bash "$personal_bootstrap"
   else
     echo "Executing default dotfiles bootstrap"
     bash "$default_bootstrap"
   fi
   ```

1. Create a script in your devcontainer configuration folder that copies over the shared configuration, when no other .dotfiles are found on the host machine

   ```bash
   #!/bin/bash

   if [ -z "$REMOTE_CONTAINERS" ]; then
     echo "This script should only be executed inside a container."
     exit 1
   fi

   SHARED_REPOSITORY="https://github.com/blissful-group/.dotfiles"
   SHARED_CONFIG_DIR=.devcontainer/config
   SHARED_PROFILE="shared"

   TMP_DIR="$(mktemp -d)"

   if [ ! -d "$SHARED_CONFIG_DIR/profiles" ]; then
     echo "Cloning shared dotfiles from $SHARED_REPOSITORY"
     git clone --depth 1 "$SHARED_REPOSITORY" "$TMP_DIR"
     rsync -av --ignore-existing "$TMP_DIR/profiles" "$SHARED_CONFIG_DIR"
   fi

   rm -rf ~/.zshrc
   rm -rf ~/.config/starship.toml

   ln -s "$(pwd)"/$SHARED_CONFIG_DIR/profiles/$SHARED_PROFILE/.zshrc ~/.zshrc
   ln -s "$(pwd)"/$SHARED_CONFIG_DIR/profiles/$SHARED_PROFILE/.config/starship.toml ~/.config/starship.toml

   rm -rf "$TMP_DIR"
   ```
