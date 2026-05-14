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

    flake.modules.nixos.${name} = { config, inputs, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.default ];
            cfg.kernel.build = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest;

            nix.settings = {
                substituters = [ "https://cache.garnix.io" ];
                trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
            };
        };
    };
}
