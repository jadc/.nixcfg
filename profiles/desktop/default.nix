top@{ inputs, lib, ... }:

let
    hostname = "jad-desktop";
    username = "jad";

    profile = { pkgs, ... }: {
        cfg = {
            # Kernel
            kernel = {
                enable = true;
                build = pkgs.linuxPackages_zen;
                flags = {
                    intel = true;
                    nvidia = true;
                    performance = true;
                    quiet = true;
                };
            };

            # Boot
            systemd-boot.enable = true;

            # System
            identity.passwordFile = "/persist/password";
            automount.enable = true;
            homeMounts = {
                enable = true;
                source = "/data";
                dirs = [ "Documents" "Music" "Pictures" "Videos" ];
            };
            impermanence = {
                enable = true;
                home.dirs = [ "Downloads" ];
            };
            libinput.enable = true;
            sound.enable = true;
            ssh.enable = true;
            swapfile = {
                enable = true;
                size = 16*1024;
            };
            timeZone = "America/Edmonton";
            trim.enable = true;

            docker.enable = true;
            droidcam.enable = true;
            fuzzel.enable = true;
            mako.enable = true;
            swaybg.image = ../wallpaper.jpg;
            swaylock.enable = true;
            waybar.enable = true;
            niri = {
                enable = true;

                # Monitor setup
                extraConfig = ''
                    output "DP-1" {
                        mode "2560x1440@239.970"
                        position x=0 y=0
                    }

                    output "HDMI-A-1" {
                        mode "1920x1080@119.993"
                        position x=2560 y=-360
                        transform "270"
                    }
                '';
            };
            rgb = {
                enable = true;
                off = true;
            };
            steam.enable = true;
            syncthing.enable = true;

            # Setup
            qt.enable = true;
            xdg.enable = true;

            # Apps
            brave.enable = true;
            deluge.enable = true;
            handbrake.enable = true;
            kitty.enable = true;
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

                inputs.stylix.nixosModules.stylix
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
