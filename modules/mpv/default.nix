{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.homeManager.${name} = { config, lib, ... }: let
        self = config.cfg.${name};
        style = config.cfg.style;
    in {
        config = lib.mkIf self.enable {
            programs.mpv = {
                enable = true;
                config = with style.colors; {
                    autofit = "50%";  # Window starts at 50% of screen size
                    "osd-font" = style.fonts.sansSerif.name;
                    "sub-font" = style.fonts.sansSerif.name;
                    "background-color" = base00.hex;
                    "osd-back-color" = base01.hex;
                    "osd-border-color" = base01.hex;
                    "osd-color" = base05.hex;
                    "osd-shadow-color" = base00.hex;
                };

                scriptOpts = with style.colors; {
                    uosc.color = lib.concatStringsSep "," [
                        "background=${base00.value}"
                        "background_text=${base05.value}"
                        "foreground=${base05.value}"
                        "foreground_text=${base00.value}"
                        "success=${base0B.value}"
                        "error=${base08.value}"
                    ];
                    modernz = {
                        seekbarfg_color = base0D.hex;
                        seekbarbg_color = base03.hex;
                        seekbar_cache_color = base03.hex;
                        window_title_color = base03.hex;
                        window_controls_color = base03.hex;
                        title_color = base05.hex;
                        time_color = base05.hex;
                        chapter_title_color = base05.hex;
                        cache_info_color = base05.hex;
                        middle_buttons_color = base0D.hex;
                        side_buttons_color = base03.hex;
                        playpause_color = base0D.hex;
                        hover_effect_color = base0E.hex;
                    };
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
    };
}
