# HP OmniBook Ultra Flip Laptop 14-fh0xxx (SBKPF)

top@{ inputs, lib, ... }:

let
    hostname = "jad-laptop";
    username = "jad";

    profile = { pkgs, ... }: {
        cfg = {
            # Kernel
            kernel = {
                enable = true;
                build = pkgs.linuxPackages_zen;
                flags = {
                    intel = true;
                    performance = true;
                    quiet = true;
                };
            };

            # Boot
            systemd-boot.enable = true;

            # System
            identity.passwordFile = "/persist/password";
            automount.enable = true;
            bluetooth.enable = true;
            impermanence = {
                enable = true;
                home.dirs = [ "Documents" "Downloads" "Music" "Pictures" "Videos" ];
            };
            fonts.enable = true;
            hp.enable = true;
            keyd.enable = true;
            libinput.enable = true;
            networkmanager.enable = true;
            sound.enable = true;
            swapfile = {
                enable = true;
                size = 4*1024;
            };
            trim.enable = true;
            wireguard = {
                enable = true;
                configurations.home = "/etc/wireguard/home.conf";
            };

            # Requires superuser
            docker.enable = true;
            fuzzel.enable = true;
            mako.enable = true;
            niri.enable = true;
            swaybg.image = ../wallpaper.jpg;
            swaylock.enable = true;
            waybar.enable = true;
            steam.enable = true;
            syncthing.enable = true;

            # Setup
            qt.enable = true;
            xdg.enable = true;

            # Apps
            brave.enable = true;
            deluge.enable = true;
            handbrake.enable = true;
            kitty = {
                enable = true;
                fontSize = 10;
            };
            nautilus.enable = true;
            minecraft.enable = true;
            obsidian.enable = true;
            qdirstat.enable = true;
            rnote.enable = true;
            spotify.enable = true;
            vesktop.enable = true;
            zathura.enable = true;
            moonlight.enable = true;

            # Multimedia
            audacity.enable = true;
            avidemux.enable = true;
            gimp.enable = true;
            inkscape.enable = true;
            jellyfin-player.enable = true;
            mpv.enable = true;
            obs.enable = true;
            puddletag.enable = true;
            spek.enable = true;
            virt-manager.enable = true;

            # Command-line Interface
            archivers.enable = true;
            bat.enable = true;
            claude-code.enable = true;
            direnv.enable = true;
            envs.enable = true;
            exiftool.enable = true;
            eza.enable = true;
            ffmpeg.enable = true;
            flac.enable = true;
            fzf.enable = true;
            gallery-dl.enable = true;
            gdb.enable = true;
            git.enable = true;
            htop.enable = true;
            hyperfine.enable = true;
            imagemagick.enable = true;
            poppler.enable = true;
            ripgrep.enable = true;
            rsync.enable = true;
            tmux.enable = true;
            yt.enable = true;
            zoxide.enable = true;
            zsh.enable = true;

            # Scripts
            spotifyify.enable = true;
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

                inputs.home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        extraSpecialArgs = { inherit inputs username; };
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        sharedModules =
                            (lib.attrValues top.config.flake.modules.generic)
                            ++ (lib.attrValues top.config.flake.modules.homeManager);
                        users.${username} = profile;
                    };
                }
            ];
    };
}
