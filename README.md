To establish symlinks on a new machine with GNU Stow run

```
stow vim
```

where the structure is .dotfiles/vim/.vimrc. This creates a symlink at
~/.vimrc, as running `stow <dir>` in /.dotfiles creates a symlink of all files
under `<dir>` in the directory above /.dotfiles
