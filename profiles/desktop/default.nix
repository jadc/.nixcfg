top@{ inputs, lib, ... }:

let
    hostname = "jad-desktop";
    username = "jad";

    profile = { ... }: {
        imports = [ ../_common ];

        cfg = {
            # Kernel
            kernel = {
                cachyos = "linuxPackages-cachyos-bore-lto-x86_64-v3";
                flags.nvidia = true;
            };

            # Setup
            homeMounts = {
                enable = true;
                source = "/data";
                dirs = [
                    "Documents"
                    "Music"
                    "Pictures"
                    "Projects"
                    "Videos"
                ];
            };
            save.home.dirs = [ "Downloads" ];
            rgb = {
                enable = true;
                off = true;
            };
            ram.swapfileSize = 16*1024;

            # Apps
            droidcam.enable = true;
            k3s.enable = true;
            unity.enable = true;
        };
    };
in
{
    flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs hostname username; };
        modules =
            (lib.attrValues top.config.flake.modules.generic)
            ++ (lib.attrValues top.config.flake.modules.nixos)
            ++ [
                ./hardware-configuration.nix
                profile
            ];
    };
}
