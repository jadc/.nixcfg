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
                flags = {
                    # Displays hang off the UHD 770. The 3080 Ti stays on the
                    # host for render offload and is handed to a guest at
                    # runtime, so nothing binds it to vfio-pci at boot.
                    intel = true;
                    nvidia = true;
                    vfio = true;
                };
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
            ram.swapfileSize = 16*1024;

            # Virtual machines
            vm = {
                enable = true;
                imageDir = "/data/vms";
                domains.win11 = ./win11.xml;
                memory = 16*1024;
                hugepages = true;
                passthrough = [
                    "0000:01:00.0"  # RTX 3080 Ti
                    "0000:01:00.1"  # its HDMI audio function
                ];
            };

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
