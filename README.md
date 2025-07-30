# [Dotfiles](https://github.com/blissful-group/.dotfiles)

The public (standard) configuration of blissful group dotfiles.

## Getting Started

### Prerequisites

This repository requires the following dependencies

1. `zsh`

   ```bash
   sudo apt install zsh
   ```

1. [starship](https://starship.rs/)

   ```bash
   curl -sS https://starship.rs/install.sh | sh -s -- -y
   ```

### Dev container

To create your own configuration for in the container, please create a custom `.dotfiles` folder in your HOME directory (`~/`).
You can mount any configuration, or install dependencies in your container, using the `~/.dotfiles/bootstrap` script.

```bash
config_folder=".devcontainer/config"
shared_profile_repository="https://github.com/blissful-group/.dotfiles"

personal_bootstrap="$HOME/.dotfiles/bootstrap"
default_bootstrap="$config_folder/bootstrap"

rm -rf "$config_folder"

if [ -e "$personal_bootstrap" ]; then
  echo "Found existing dotfiles bootstrap"
  ln -s "$HOME/.dotfiles/" "$(pwd)"/$config_folder
else
  echo "Retrieving default dotfiles bootstrap"
  git clone --depth 1 "$shared_profile_repository" "$(pwd)"/$config_folder
fi

bash "$default_bootstrap"
```

## Best practices

Best practices is to move your stored configurations to the `.dotfiles` folder.

- .zshrc
- .bashrc
- etc...

Anything in the .dotfiles folder will be automatically mounted in the development container, which you can then symlink to the `vscode` user configuration with a script like so:

```shell
#!/bin/bash

profile="profile_name"

rm -rf ~/.zshrc
rm -rf ~/.bashrc
rm -rf ~/...

ln -s $HOME/.dotfiles/$profile/.zshrc ~/.zshrc
ln -s $HOME/.dotfiles/$profile/.bashrc ~/.bashrc
ln -s $HOME/.dotfiles/$profile/... ~/...
```

## [Blissful Group ![Logo](./public/favicon-16x16.png)](https://blissful.group)