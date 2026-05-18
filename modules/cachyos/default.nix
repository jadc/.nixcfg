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
            nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
            cfg.kernel.build = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest;

            nix.settings = {
                substituters = [
                    "https://attic.xuyh0120.win/lantian"
                    "https://cache.garnix.io"
                ];
                trusted-public-keys = [
                    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
                    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
                ];
            };
        };
    };
}
