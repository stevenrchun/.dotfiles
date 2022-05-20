To establish symlinks on a new machine with GNU Stow run

```
stow vim
```

where the structure is .dotfiles/vim/.vimrc. This creates a symlink at
~/.vimrc, as running `stow <dir>` in /.dotfiles creates a symlink of all files
under `<dir>` in the directory above /.dotfiles

Also, because several Vim workflows use `fzf` and `Ag`, it's worth noting them
here to remember to install on new machines.

For the Silver Searcher:

```
brew install the_silver_searcher
```

For fzf:
```
brew install fzf
$(brew --prefix)/opt/fzf/install
```
The latter command being for things like key bindings (mainly the reverse
search) and completion.
