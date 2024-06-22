# jad's nixcfg

## Installation

```sh
cd $HOME
git clone https://github.com/jad-c/.nixcfg.git
# Edit profile.nix to your desired profile (the folders in the profiles directory)
sudo nixos-rebuild switch --flake .nixcfg
home-manager switch --flake .nixcfg
```
