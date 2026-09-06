# HP OmniBook Ultra Flip Laptop 14-fh0xxx (SBKPF)

top@{ inputs, lib, ... }:

let
    hostname = "jad-laptop";
    username = "jad";

    profile = { ... }: {
        imports = [ ../_common ];

        # Keep the speaker-capable profile preferred when HDMI is connected.
        # HDMI sinks remain available and can still be selected normally.
        services.pipewire.wireplumber.extraConfig."51-prefer-speakers" = {
            "device.profile.priority.rules" = [
                {
                    matches = [
                        {
                            "device.name" = "alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic";
                        }
                    ];
                    actions.update-props.priorities = [
                        "HiFi (HDMI1, HDMI2, HDMI3, Mic1, Mic2, Speaker)"
                    ];
                }
            ];
        };

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

            # Services
            ssh.enable = true;

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
