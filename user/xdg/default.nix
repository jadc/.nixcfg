{ config, ... }:

{
    xdg.userDirs = let home = config.home.homeDirectory; in {
        enable = true;
        createDirectories = true;

        download = "${home}/downloads";
        desktop = config.xdg.userDirs.download;
        documents = "${home}/docs";
        music = "${home}/music";
        pictures = "${home}/pics";
        videos = "${home}/videos";
    };
}
