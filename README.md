# jad's nixcfg

## Installation

### NixOS
#### 1. Install Nix
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

#### 2. Clone Config
```sh
cd $HOME && git clone https://github.com/jadc/.nixcfg.git
```

Generate `hardware-configuration.nix` with `nixos-generate-config --root /mnt` and move it into the appropriate profile in the `config` directory.

#### 3. Create Password file

The user and root share a hashed password read from the path set by `cfg.identity.passwordFile`.
_If using impermanence, use the path `/persist/password`, otherwise use the default `/password`._

```sh
mkpasswd -m sha-512 | sudo tee <path> >/dev/null
sudo chmod 600 <path>
```

#### 4. Switch to config
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
