# dotfiles

A repository to keep track of my dotfiles. Directory structured to be used with
[stow](https://www.gnu.org/software/stow/).

# Usage

1. Clone this repository in user home directory (~/)
2. Change directory to the root of this repository
3. Execute `stow <package>` to create symlink from `<repo>/<pkg-name>/` to `~/`
4. Pull submodules with `git submodule update --init --recursive`
