# jad's nixcfg

## Architecture

This is a **flake-parts** NixOS configuration using **import-tree** for automatic module discovery. The flake produces NixOS system configurations and standalone home-manager configurations.

### Flake structure

```
flake.nix
├── imports import-tree ./modules   (auto-discovers all modules/)
├── imports ./profiles              (auto-discovers all profile subdirs)
└── uses flake-parts.flakeModules.modules  (enables the three-namespace system)
```

### Three-namespace module system

Every module in `modules/<name>/default.nix` can declare up to three flake module attributes:

| Namespace | Purpose | Where it runs |
|---|---|---|
| `flake.modules.generic.<name>` | Option declarations (`options.cfg.<name>`) | Everywhere — shared by NixOS and home-manager |
| `flake.modules.nixos.<name>` | System-level implementation (`config = lib.mkIf ...`) | NixOS only |
| `flake.modules.homeManager.<name>` | User-level implementation | Home Manager only |

All three namespaces share the `cfg.*` option tree. The `home-manager` module (`modules/home-manager/`) passes `config.cfg` from NixOS into home-manager via `users.${username}.cfg = config.cfg`, so options set in a profile are visible to both NixOS and home-manager modules.

### Module pattern

```nix
{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable { /* ... */ };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable { /* ... */ };
    };
}
```

A module only needs the namespaces it uses — many modules omit `nixos` or `homeManager`. The module name is derived from the directory name via `baseNameOf (toString ./.)`.

### Profiles

Profiles live in `profiles/<name>/` and define a complete machine configuration by setting `cfg.*` options:

- **desktop** (`jad-desktop`): Full workstation — Niri WM, NVIDIA+Intel GPU, impermanence, 100+ modules enabled
- **laptop** (`jad-laptop`): Similar to desktop without NVIDIA, adds bluetooth/wireguard/battery
- **home**: Standalone home-manager config (CLI tools only, no NixOS), produces `home-<system>` outputs for all platforms

Each NixOS profile composes its module list as:
```nix
modules = (lib.attrValues top.config.flake.modules.generic)
       ++ (lib.attrValues top.config.flake.modules.nixos)
       ++ [ ./hardware-configuration.nix  profile ];
```

### Impermanence

All NixOS systems use ephemeral root (tmpfs). Persistent state goes under `/persist`. Modules declare what to persist via `cfg.impermanence.root.{dirs,files}` and `cfg.impermanence.home.{dirs,files}`.

### Adding a new module

1. Create `modules/<name>/default.nix` following the module pattern above
2. It will be auto-imported by import-tree — no registration needed
3. Enable it in the relevant profile(s) with `cfg.<name>.enable = true`

### Key inputs

- **nixpkgs**: nixos-unstable channel
- **flake-parts**: Modular flake framework
- **import-tree**: Auto-import directories as flake modules
- **home-manager**: User environment management (follows nixpkgs)
- **impermanence**: Ephemeral root filesystem support
- **stylix**: System-wide theming (follows nixpkgs)
- **nvim**: External neovim flake (`github:jadc/nvim`)

### Nix conventions in this repo

- Unfree packages are allowed (`nixpkgs.config.allowUnfree = true`)
- Shell aliases are declared via `cfg.const.aliases` and shared across all modules
- Special args `inputs`, `hostname`, `username` are passed to all modules


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

