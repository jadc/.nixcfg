# jad's nixcfg

## Installation

### Nix
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Config
```sh
cd $HOME && git clone https://github.com/jadc/.nixcfg.git
```

Generate `hardware-configuration.nix` with `nixos-generate-config --root /mnt` and move it into the appropriate profile in the `config` directory.

### NixOS
```sh
sudo nixos-rebuild switch --flake ~/.nixcfg
```

### Home Manager Only
```sh
# Initial install
nix run home-manager/master -- init --switch

# After any change
home-manager switch --flake ~/.nixcfg
```
