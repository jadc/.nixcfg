# Nautilus: Gnome file manager

{ config, lib, pkgs, ... }:

let
    name = "nautilus";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = with pkgs; [
            nautilus

            # Extensions (TODO: delete redundant extensions)
            gthumb    # Image thumbnails
            eog       # Image thumbnails
            evince    # PDF thumbnails
            totem     # Video thumbnails
            ffmpegthumbnailer  # Video thumbnails
            gst_all_1.gst-libav # Video thumbnails
            gst_all_1.gst-plugins-ugly # Video thumbnails
        ];

        # Settings
        dconf.settings = {
            "org/gnome/nautilus/preferences" = {
                # Set default folder view to details
                default-folder-viewer = "list-view";

                # Always show path in title bar
                always-use-location-entry = true;
            };
        };
    };
}
