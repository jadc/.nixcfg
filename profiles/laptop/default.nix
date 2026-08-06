# HP OmniBook Ultra Flip Laptop 14-fh0xxx (SBKPF)

top@{ inputs, lib, ... }:

let
    hostname = "jad-laptop";
    username = "jad";

    profile = { ... }: {
        imports = [ ../_common ];

        cfg = {
            # Kernel
            kernel = {
                cachyos = "linuxPackages-cachyos-bore-lto-x86_64-v3";
            };

            # Setup
            bluetooth.enable = true;
            hp.enable = true;
            save.home.dirs = [
                "Documents"
                "Downloads"
                "Music"
                "Pictures"
                "Projects"
                "Videos"
            ];
            ram = {
                swapfileSize = 4*1024;
                zramPercent = 50;
                oomThreshold = 5;
            };

            # Apps
            power.enable = true;
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
