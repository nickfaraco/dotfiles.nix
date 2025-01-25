# dotfiles.nix

## WSL and standalone installations
If you want to use Home-manager as a standalone installation on, say, WSL, follow these instructions:

1. Install home-manager as a standalone flake and create the first generation (default one) for the tool to become available in the command-line:

``` sh
nix run home-manager/master -- init --switch
```
`master` here can be substituted with any stable branch, if preferred.

2. Clone this repo and switch generation again

```sh
git clone git@github.com:nickfaraco/dotfiles.nix.git nix
cd nix
home-manager switch --flake .
```
