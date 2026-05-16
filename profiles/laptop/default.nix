# HP OmniBook Ultra Flip Laptop 14-fh0xxx (SBKPF)

top@{ inputs, lib, ... }:

let
    hostname = "jad-laptop";
    username = "jad";

    profile = { pkgs, config, ... }: {
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
            cachyos.enable = true;
            systemd-boot.enable = true;

            # Setup
            automount.enable = true;
            bluetooth.enable = true;
            hp.enable = true;
            identity.passwordFile = "${config.cfg.save.path}/password";
            save = {
                enable = true;
                home.dirs = [
                    "Documents"
                    "Downloads"
                    "Music"
                    "Pictures"
                    "Projects"
                    "Videos"
                ];
            };
            networkmanager.enable = true;
            qt.enable = true;
            sound.enable = true;
            swapfile = {
                enable = true;
                size = 4*1024;
            };
            trim.enable = true;
            xdg.enable = true;

            # Apps
            audacity.enable = true;
            avidemux.enable = true;
            brave.enable = true;
            bruno.enable = true;
            deluge.enable = true;
            docker.enable = true;
            gimp.enable = true;
            handbrake.enable = true;
            inkscape.enable = true;
            jellyfin-player.enable = true;
            kitty.enable = true;
            minecraft.enable = true;
            moonlight.enable = true;
            mpv.enable = true;
            nautilus.enable = true;
            niri.enable = true;
            noctalia.enable = true;
            swaybg.wallpaper = ../wallpaper.jpg;
            obs.enable = true;
            obsidian.enable = true;
            puddletag.enable = true;
            qdirstat.enable = true;
            rnote.enable = true;
            spek.enable = true;
            spotify.enable = true;
            gamemode.enable = true;
            steam.enable = true;
            syncthing.enable = true;
            wireguard = {
                enable = true;
                configurations.home = "/etc/wireguard/home.conf";
            };
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
