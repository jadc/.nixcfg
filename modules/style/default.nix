# Original custom scheme:
# base00 = "000000"; base01 = "252525"; base02 = "535353"; base03 = "505050";
# base04 = "7fc8ff"; base05 = "ffffff"; base06 = "ffffff"; base07 = "ffffff";
# base08 = "ff009e"; base09 = "ff00d4"; base0A = "fffd00"; base0B = "00ffa2";
# base0C = "00ffea"; base0D = "00e0ff"; base0E = "00efff"; base0F = "f274bc";

{ inputs, ... }:

{
    flake.modules.generic.style = { lib, pkgs, ... }: let
        helpers = import ./_helper.nix { inherit lib; };
    in
    {
        options.cfg.style = {
            colors = {
                base00 = helpers.color "000000";
                base01 = helpers.color "282828";
                base02 = helpers.color "585858";
                base03 = helpers.color "888888";
                base04 = helpers.color "c8c8c8";
                base05 = helpers.color "ffffff";
                base06 = helpers.color "ffffff";
                base07 = helpers.color "ffffff";
                base08 = helpers.color "fa7883";
                base09 = helpers.color "ffc387";
                base0A = helpers.color "ff9470";
                base0B = helpers.color "98c379";
                base0C = helpers.color "8af5ff";
                base0D = helpers.color "6bb8ff";
                base0E = helpers.color "e799ff";
                base0F = helpers.color "b3684f";
            };

            cursor = {
                package = lib.mkOption {
                    type = lib.types.package;
                    default = pkgs.apple-cursor;
                };
                name = lib.mkOption {
                    type = lib.types.str;
                    default = "macOS";
                };
                size = lib.mkOption {
                    type = lib.types.ints.positive;
                    default = 20;
                };
            };

            opacity = {
                applications = lib.mkOption {
                    type = lib.types.float;
                    default = 0.85;
                };
                terminal = lib.mkOption {
                    type = lib.types.float;
                    default = 0.85;
                };
            };

            fonts = {
                monospace = {
                    package = lib.mkOption {
                        type = lib.types.package;
                        default = pkgs.maple-mono.NF-unhinted;
                    };
                    name = lib.mkOption {
                        type = lib.types.str;
                        default = "Maple Mono NF";
                    };
                };
                sansSerif = {
                    package = lib.mkOption {
                        type = lib.types.package;
                        default = pkgs.open-sans;
                    };
                    name = lib.mkOption {
                        type = lib.types.str;
                        default = "Open Sans";
                    };
                };
                serif = {
                    package = lib.mkOption {
                        type = lib.types.package;
                        default = pkgs.noto-fonts;
                    };
                    name = lib.mkOption {
                        type = lib.types.str;
                        default = "Noto Serif";
                    };
                };
                emoji = {
                    package = lib.mkOption {
                        type = lib.types.package;
                        default = pkgs.twemoji-color-font;
                    };
                    name = lib.mkOption {
                        type = lib.types.str;
                        default = "Twemoji Color Emoji";
                    };
                };

                sizes.terminal = lib.mkOption {
                    type = lib.types.ints.positive;
                    default = 13;
                };
            };
        };
    };

    flake.modules.nixos.style = { config, pkgs, ... }: let
        style = config.cfg.style;
    in {
        imports = [ inputs.stylix.nixosModules.stylix ];

        config.stylix = {
            enable = true;

            # Theme
            polarity = "dark";
            base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-black.yaml";

            # Keep Stylix targets on the shared fonts while they are migrated.
            fonts = {
                inherit (style.fonts) monospace sansSerif serif emoji;
                sizes.terminal = style.fonts.sizes.terminal;
            };

            targets = {
                # These are now configured without Stylix below.
                fontconfig.enable = false;
                font-packages.enable = false;

                # Disable forcing Chromium theme.
                chromium.enable = false;
            };
        };

        config.fonts = {
            packages = [
                style.fonts.monospace.package
                style.fonts.sansSerif.package
                style.fonts.serif.package
                style.fonts.emoji.package

                pkgs.dejavu_fonts
                pkgs.freefont_ttf
                pkgs.gyre-fonts
                pkgs.liberation_ttf
                pkgs.unifont

                # Asian fonts
                pkgs.noto-fonts-cjk-sans
                pkgs.noto-fonts-cjk-serif
            ];

            fontconfig.defaultFonts = {
                monospace = [ style.fonts.monospace.name ];
                sansSerif = [ style.fonts.sansSerif.name ];
                serif = [ style.fonts.serif.name ];
                emoji = [ style.fonts.emoji.name ];
            };
        };

        config.environment.sessionVariables = {
            FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
        };
    };

    flake.modules.homeManager.style = { config, lib, pkgs, ... }: let
        style = config.cfg.style;
    in {
        config = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
            home.pointerCursor = {
                inherit (style.cursor) package name size;
                enable = true;
                gtk.enable = true;
                x11.enable = true;
            };
        };
    };
}
