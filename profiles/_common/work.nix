# Command-line Applications

{ lib, ... }:

{
    cfg = lib.mkDefault {
        archivers.enable = true;
        bat.enable = true;
        direnv.enable = true;
        envs.enable = true;
        exiftool.enable = true;
        eza.enable = true;
        ffmpeg.enable = true;
        fzf.enable = true;
        git.enable = true;
        htop.enable = true;
        hyperfine.enable = true;
        imagemagick.enable = true;
        pi.enable = true;
        poppler.enable = true;
        ripgrep.enable = true;
        rsync.enable = true;
        tmux.enable = true;
        xdg.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
    };
}
