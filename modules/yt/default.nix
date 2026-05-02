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

    flake.modules.homeManager.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            programs.yt-dlp = {
                enable = true;

                settings = {
                    ignore-errors = true;
                    no-continue = true;
                    no-overwrites = true;
                    add-metadata = true;
                    #embed-thumbnail = true;
                    #all-subs = true;
                    #sub-format = "srt";
                    #embed-subs  = true;
                    output = "%(title)s.%(ext)s";

                    # Download as MP4 if possible
                    format-sort = "res,ext:mp4:m4a";
                };
            };
        };
    };
}
