{ inputs, ... }:

{
    flake.modules.nixos.stylix = { pkgs, ... }: {
        imports = [ inputs.stylix.nixosModules.stylix ];

        config.stylix = {
            enable = true;

            # Original custom scheme:
            # base00 = "000000"; base01 = "252525"; base02 = "535353"; base03 = "505050";
            # base04 = "7fc8ff"; base05 = "ffffff"; base06 = "ffffff"; base07 = "ffffff";
            # base08 = "ff009e"; base09 = "ff00d4"; base0A = "fffd00"; base0B = "00ffa2";
            # base0C = "00ffea"; base0D = "00e0ff"; base0E = "00efff"; base0F = "f274bc";

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
                    package = pkgs.nerd-fonts.jetbrains-mono;
                    name = "JetBrainsMono Nerd Font";
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
