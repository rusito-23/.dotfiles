
# Neovim Dotfiles

## Plugins

I'm using [dein](https://github.com/Shougo/dein.vim) as plugin manager.

Plugins included:

- [NERDTree](https://github.com/preservim/nerdtree)
- [deoplete](https://github.com/Shougo/deoplete.nvim)
- [deoplete-jedi](https://github.com/zchee/deoplete-jedi)
- [jedi-vim](https://github.com/davidhalter/jedi-vim)
- [vim-airline](https://github.com/vim-airline)
- [auto-pairs](https://github.com/jiangmiao/auto-pairs)
- [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
- [neoformat](https://github.com/sbdchd/neoformat)
- [neomake](https://github.com/neomake/neomake)
- [onedark colorscheme](https://github.com/joshdick/onedark.vim)
- [tagbar](https://github.com/majutsushi/tagbar)

## Install

To install run the script: 
```
./.dotfiles/nvim/install.sh
```

And finally, open nvim and run:
```vim
call dein#install()
```

## Dependencies

- [ctags](http://ctags.sourceforge.net)
