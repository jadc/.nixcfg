{ config, ... }:

{
    cfg.user = let cfg = config.cfg; in {
        archivers.enable = true;
        bat.enable = true;
        claude-code.enable = true;
        direnv.enable = true;
        envs.enable = true;
        eza.enable = true;
        fzf.enable = true;
        gdb.enable = true;
        git.enable = true;
        htop.enable = true;
        hyperfine.enable = true;
        neovim.enable = true;
        ripgrep.enable = true;
        shells = {
            enable = true;
            aliases = cfg.const.aliases;
        };
        tmux.enable = true;
        zoxide.enable = true;
    };
}
