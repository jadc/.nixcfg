# Original custom scheme:
# base00 = "000000"; base01 = "252525"; base02 = "535353"; base03 = "505050";
# base04 = "7fc8ff"; base05 = "ffffff"; base06 = "ffffff"; base07 = "ffffff";
# base08 = "ff009e"; base09 = "ff00d4"; base0A = "fffd00"; base0B = "00ffa2";
# base0C = "00ffea"; base0D = "00e0ff"; base0E = "00efff"; base0F = "f274bc";

{ inputs, ... }:

{
    flake.modules.generic.style = { lib, ... }:
    let
        color = default: lib.mkOption {
            type = lib.types.str;
            inherit default;
        };
    in
    {
        options.cfg.style.colors = {
            base00 = color "#000000";
            base01 = color "#282828";
            base02 = color "#585858";
            base03 = color "#888888";
            base04 = color "#c8c8c8";
            base05 = color "#ffffff";
            base06 = color "#ffffff";
            base07 = color "#ffffff";
            base08 = color "#fa7883";
            base09 = color "#ffc387";
            base0A = color "#ff9470";
            base0B = color "#98c379";
            base0C = color "#8af5ff";
            base0D = color "#6bb8ff";
            base0E = color "#e799ff";
            base0F = color "#b3684f";
        };
    };

    flake.modules.nixos.style = { pkgs, ... }: {
        imports = [ inputs.stylix.nixosModules.stylix ];

        config.stylix = {
            enable = true;

            opacity = {
                applications = 0.85;
                terminal = 0.85;
            };

            # Theme
            polarity = "dark";
            base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-black.yaml";

            cursor = {
                package = pkgs.apple-cursor;
                name = "macOS";
                size = 20;
            };

            fonts = {
                sizes.terminal = 13;

                monospace = {
                    package = pkgs.maple-mono.NF-unhinted;
                    name = "Maple Mono NF";
                };
                sansSerif = {
                    package = pkgs.open-sans;
                    name = "Open Sans";
                };
                serif = {
                    package = pkgs.noto-fonts;
                    name = "Noto Serif";
                };
                emoji = {
                    package = pkgs.twemoji-color-font;
                    name = "Twemoji Color Emoji";
                };
            };

            # Disable forcing Chromium theme
            targets.chromium.enable = false;
        };

        config.fonts = {
            packages = [
                pkgs.dejavu_fonts
                pkgs.freefont_ttf
                pkgs.gyre-fonts
                pkgs.liberation_ttf
                pkgs.unifont

                # Asian fonts
                pkgs.noto-fonts-cjk-sans
                pkgs.noto-fonts-cjk-serif
            ];
        };

        config.environment.sessionVariables = {
            FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
        };
    };
}
