{ config, lib, ... }:

let
    name = "mpv";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.mpv = {
            enable = true;
            config = {
                autofit = "50%";  # Window starts at 50% of screen size
            };
        };

        xdg.mimeApps.defaultApplications = {
            # Video
            "video/mp4" = "mpv.desktop";
            "video/x-matroska" = "mpv.desktop";
            "video/webm" = "mpv.desktop";
            "video/x-msvideo" = "mpv.desktop";
            "video/quicktime" = "mpv.desktop";
            "video/x-flv" = "mpv.desktop";
            "video/ogg" = "mpv.desktop";
            "video/3gpp" = "mpv.desktop";
            "video/3gpp2" = "mpv.desktop";
            "video/x-m4v" = "mpv.desktop";
            "video/mpeg" = "mpv.desktop";

            # Audio
            "audio/mpeg" = "mpv.desktop";
            "audio/ogg" = "mpv.desktop";
            "audio/flac" = "mpv.desktop";
            "audio/x-wav" = "mpv.desktop";
            "audio/mp4" = "mpv.desktop";
            "audio/aac" = "mpv.desktop";
            "audio/x-m4a" = "mpv.desktop";
            "audio/webm" = "mpv.desktop";
            "audio/opus" = "mpv.desktop";
            "audio/x-aiff" = "mpv.desktop";
        };
    };
}
