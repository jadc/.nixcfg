# HP OmniBook Ultra Flip Laptop 14-fh0xxx (SBKPF)

{ home }: { lib, config, pkgs, ... }:

{
    cfg = let cfg = config.cfg; in {
        const = {
            profile = "laptop";
            arch = "x86_64-linux";
            username = "jad";
        };

        system = lib.mkIf (!home) {
            # Kernel configuration
            kernel = {
                enable = true;
                build = pkgs.linuxPackages_zen;
                flags = {
                    intel = true;
                    performance = true;
                    quiet = true;
                };
            };

            # Boot configuration
            systemd-boot.enable = true;

            # System configuration
            autologin.enable = true;
            automount.enable = true;
            bluetooth.enable = true;
            fonts.enable = true;
            gc.enable = true;
            hp-rotate.enable = true;
            intel.enable = true;
            ios.enable = true;
            keyd.enable = true;
            libinput.enable = true;
            networkmanager.enable = true;
            sound.enable = true;
            swapfile.enable = true;
            trim.enable = true;
            users.enable = true;

            # Requires superuser
            docker.enable = true;
            gnome.enable = true;
            steam.enable = true;
            syncthing.enable = true;
        };

        user = lib.mkIf home {
            # Setup
            qt.enable = true;
            xdg.enable = true;

            # Apps
            chrome.enable = true;
            deluge.enable = true;
            kitty.enable = true;
            minecraft.enable = true;
            obsidian.enable = true;
            parallel-launcher.enable = true;
            qdirstat.enable = true;
            rnote.enable = true;
            spotify.enable = true;
            vesktop.enable = true;
            zathura.enable = true;

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
            neovim.enable = true;
            poppler.enable = true;
            ripgrep.enable = true;
            rsync.enable = true;
            shells = {
                enable = true;
                aliases = cfg.const.aliases;
            };
            tmux.enable = true;
            yt.enable = true;
            zoxide.enable = true;

            # Scripts
            Scripts.enable = true;
        };
    };
}
