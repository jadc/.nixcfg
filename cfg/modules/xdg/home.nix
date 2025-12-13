{ config, lib, ... }:

let
    name = "xdg";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        xdg = {
            enable = true;
            userDirs = let
                home = config.home.homeDirectory;
            in {
                enable = true;
                createDirectories = true;

                download = "${home}/downloads";
                desktop = config.xdg.userDirs.download;
                documents = "${home}/docs";
                music = "${home}/music";
                pictures = "${home}/pics";
                videos = "${home}/videos";
            };
        };
    };
}
