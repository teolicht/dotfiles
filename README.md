# For myself

## Old machine:
- Try to keep Homebrew packages & VSCode extensions lists updated:
```bash
~/.dotfiles/packages/update.sh
```

## New machine:
1. Clone this repo into `~/.dotfiles/`
2. Run `~/.dotfiles/symlinks.sh` (be careful with what is gonna happen)


### Install `typewritten` theme for `oh-my-zsh`
1. Clone repository into custom `oh-my-zsh` themes directory:
```zsh
git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
```
2. Ensure `typewritten.zsh` is in `$ZSH_CUSTOM` (should have been cloned).

### Install Homebrew packages
```bash
xargs brew install < brew-formulae.txt
xargs brew install --cask < brew-casks.txt
```

### Install VSCode extensions
```bash
cat vscode-extensions.txt | xargs -L 1 code --install-extension
```
