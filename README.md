# Dotfiles
This repository contains configuration files for most of the programs I use.

## General setup
#### Keyboard
* Hardware: [Ergomin](https://github.com/julianschuler/keyboards/tree/master/ergomin), custom designed ergonomic keyboard
* Layout: [modified VOU layout](https://github.com/julianschuler/keyboards/blob/master/ergomin/qmk/keymaps/julianschuler/keymap.c#L52) (optimized for German and English)

#### General
* Operating system: [Arch Linux](https://archlinux.org/)
* Package manager: [Paru](https://github.com/morganamilo/paru)
* Font: [Source Code Pro Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro)


#### Terminal
* Terminal emulator: [Alacritty](https://alacritty.org/)
* Shell: [fish](https://github.com/fish-shell/fish-shell)
* Prompt: [starship](https://github.com/starship/starship)
* File manager: [ranger](https://github.com/ranger/ranger)
* Smart directory switching: [zoxide](https://github.com/ajeetdsouza/zoxide)
* Cat with syntax highlighting: [bat](https://github.com/sharkdp/bat)
* Faster grep alternative: [ripgrep](https://github.com/BurntSushi/ripgrep)
* Improved diffs: [delta](https://github.com/dandavison/delta)
* Fuzzy finder: [fzf](https://github.com/junegunn/fzf)
* Improved ls: [exa](https://github.com/ogham/exa)

#### Editor
* Editor: [Vim](https://github.com/vim/vim)
* Plugin manager: [vim-plug](https://github.com/junegunn/vim-plug)

#### Browser
* Browser: [Firefox](https://www.mozilla.org/de/firefox/new)
* Addons: [Surfingkeys](https://github.com/brookhong/Surfingkeys), [Dark Reader](https://github.com/darkreader/darkreader)

#### Desktop
* Window manager: [spectrwm](https://github.com/conformal/spectrwm)
* Status bar: [conky](https://github.com/brndnmtthws/conky)
* Email client: [aerc](https://git.sr.ht/~rjarry/aerc)
* PDF viewer: [zathura](https://pwmt.org/projects/zathura)
* Password manager: [KeePassXC](https://keepassxc.org)

## Applying the configuration
The provided script `apply-config.sh` can be used to apply some or all parts of the configuration. See `apply-config.sh -h` for further information.

## License
This repository is licensed under the MIT license, see [`LICENSE.txt`](LICENSE.txt) for further information.
