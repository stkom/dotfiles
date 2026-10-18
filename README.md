# dotfiles
Some of my configuration files used by several machines.
Powered by https://github.com/twpayne/chezmoi.

## Requirements
git, zsh, neovim, fzf and starship. Optional: fd, fastfetch.
Missing programs are reported as warnings on the first `chezmoi apply`.

## Initializing on new machine
1. Install chezmoi and clone the repository with `chezmoi init https://github.com/stkom/dotfiles.git`
2. Check what would change with `chezmoi diff`
3. Apply the changes with `chezmoi apply`

## Making changes
- Edit managed files with `chezmoi edit <file>`, or edit them in place and run `chezmoi re-add`
- `chezmoi diff` shows anything that has drifted from the repository
- On the other machines, run `chezmoi update`
- After `:Lazy update` in nvim, run `chezmoi re-add ~/.config/nvim/lazy-lock.json`
- After changing `.chezmoi.toml.tmpl`, run `chezmoi init` to regenerate the config
