# jad's nixcfg

## Installation

### Nix
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Config
```sh
cd $HOME && git clone https://github.com/jad-c/.nixcfg.git
```

### NixOS
```sh
sudo nixos-rebuild switch --flake ~/.nixcfg
```

### nix-darwin
```sh
sudo darwin-rebuild switch --flake ~/.nixcfg
```

### Home Manager Only
```sh
home-manager switch --flake ~/.nixcfg
```
