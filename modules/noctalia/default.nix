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

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            # Use pre-compiled binaries from noctalia cache if available
            nix.settings = {
                substituters = [ "https://noctalia.cachix.org" ];
                trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
            };
        };
    };

    flake.modules.homeManager.${name} = { config, lib, inputs, ... }: let
        self = config.cfg.${name};
        colors = config.cfg.style.colors;
    in {
        imports = [ inputs.noctalia.homeModules.default ];

        config = lib.mkIf self.enable {
            # Persist runtime settings overrides across reboots
            cfg.save.home.dirs = [
                ".local/state/noctalia"
            ];

            programs.noctalia = let
                palette = "oledmono";
            in {
                enable = true;
                systemd.enable = true;

                customPalettes.${palette}.dark = {
                    mError            = "#ffffff";
                    mHover            = "#222222";
                    mOnError          = "#000000";
                    mOnHover          = "#ffffff";
                    mOnPrimary        = "#000000";
                    mOnSecondary      = "#000000";
                    mOnSurface        = "#ffffff";
                    mOnSurfaceVariant = "#cccccc";
                    mOnTertiary       = "#000000";
                    mOutline          = "#444444";
                    mPrimary          = "#ffffff";
                    mSecondary        = "#cccccc";
                    mShadow           = "#000000";
                    mSurface          = "#000000";
                    mSurfaceVariant   = "#1a1a1a";
                    mTertiary         = "#999999";

                    terminal = {
                        background   = colors.base00.hex;
                        bright = {
                            black   = colors.base03.hex;
                            blue    = colors.base0D.hex;
                            cyan    = colors.base0C.hex;
                            green   = colors.base0B.hex;
                            magenta = colors.base0E.hex;
                            red     = colors.base08.hex;
                            white   = colors.base07.hex;
                            yellow  = colors.base0A.hex;
                        };
                        cursor       = colors.base05.hex;
                        cursorText   = colors.base00.hex;
                        foreground   = colors.base05.hex;
                        normal = {
                            black   = colors.base00.hex;
                            blue    = colors.base0D.hex;
                            cyan    = colors.base0C.hex;
                            green   = colors.base0B.hex;
                            magenta = colors.base0E.hex;
                            red     = colors.base08.hex;
                            white   = colors.base05.hex;
                            yellow  = colors.base0A.hex;
                        };
                        selectionBg  = colors.base02.hex;
                        selectionFg  = colors.base05.hex;
                    };
                };

                settings = {
                    # Make a noise when adjusting volume
                    audio.enable_sounds = true;

                    # Bar layout
                    bar.main = {
                        margin_edge = 0;
                        margin_ends = 0;
                        padding = 8;
                        radius = 0;
                        scale = 1.1;
                        shadow = false;
                        widget_spacing = 8;

                        start  = [ "workspaces" "media" ];
                        center = [ "clock" ];
                        end    = [ "network" "bluetooth" "battery" ];
                    };

                    # Control center
                    control_center.shortcuts = [
                        { type = "wifi"; }
                        { type = "bluetooth"; }
                        { type = "nightlight"; }
                        { type = "notification"; }
                        { type = "caffeine"; }
                        { type = "power_profile"; }
                    ];

                    # Location
                    location.auto_locate = true;

                    # Night light
                    nightlight = {
                        enabled = true;
                        temperature_night = 2500;
                    };

                    shell = {
                        corner_radius_scale = 0.5;
                        font_family = config.cfg.style.fonts.sansSerif.name;
                        shadow.alpha = 0.0;
                        show_location = false;
                        time_format = "{:%-I:%M %p}";
                    };

                    theme = {
                        source = "custom";
                        custom_palette = lib.mkForce palette;
                    };

                    # Disable wallpaper handling
                    wallpaper.enabled = false;

                    widget = {
                        clock = {
                            format = "{:%-I:%M:%S %p}";
                            tooltip_format = "{:%A, %B %d}";
                            vertical_format = "";
                        };
                        media = {
                            hide_when_no_media = true;
                            max_length = 360;
                            title_scroll = "on_hover";
                        };
                        workspaces = {
                            display = "id";
                            empty_color = "surface";
                            focused_color = "primary";
                            hide_when_empty = true;
                            labels_only_when_occupied = true;
                            max_label_chars = 2;
                            occupied_color = "surface";
                            pill_scale = 1.25;
                        };
                    };
                };
            };
        };
    };
}
