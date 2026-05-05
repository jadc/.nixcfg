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
            systemd-boot.enable = true;

            # Setup
            automount.enable = true;
            homeMounts = {
                enable = true;
                source = "/data";
                dirs = [ "Documents" "Music" "Pictures" "Videos" ];
            };
            identity.passwordFile = "/persist/password";
            impermanence = {
                enable = true;
                home.dirs = [ "Downloads" ];
            };
            qt.enable = true;
            rgb = {
                enable = true;
                off = true;
            };
            sound.enable = true;
            ssh.enable = true;
            swapfile = {
                enable = true;
                size = 16*1024;
            };
            timeZone = "America/Edmonton";
            trim.enable = true;
            xdg.enable = true;

            # Apps
            audacity.enable = true;
            avidemux.enable = true;
            brave.enable = true;
            deluge.enable = true;
            docker.enable = true;
            droidcam.enable = true;
            gimp.enable = true;
            handbrake.enable = true;
            inkscape.enable = true;
            jellyfin-player.enable = true;
            kitty.enable = true;
            minecraft.enable = true;
            moonlight.enable = true;
            mpv.enable = true;
            nautilus.enable = true;
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
            noctalia.enable = true;
            swaybg.wallpaper = ../wallpaper.jpg;
            obs.enable = true;
            obsidian.enable = true;
            puddletag.enable = true;
            qdirstat.enable = true;
            rnote.enable = true;
            spek.enable = true;
            spotify.enable = true;
            steam.enable = true;
            syncthing.enable = true;
            vesktop.enable = true;
            virt-manager.enable = true;
            zathura.enable = true;

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
            ];
    };
}
