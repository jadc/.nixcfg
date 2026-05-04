top@{ inputs, lib, ... }:

let
    username = "jad";

    profile = {
        cfg = {
            # Setup
            ssh.enable = true;
            xdg.enable = true;

            # Command-line Interface
            archivers.enable = true;
            bat.enable = true;
            claude-code.enable = true;
            direnv.enable = true;
            envs.enable = true;
            exiftool.enable = true;
            eza.enable = true;
            ffmpeg.enable = true;
            fzf.enable = true;
            gdb.enable = true;
            git.enable = true;
            htop.enable = true;
            hyperfine.enable = true;
            imagemagick.enable = true;
            poppler.enable = true;
            ripgrep.enable = true;
            rsync.enable = true;
            tmux.enable = true;
            zoxide.enable = true;
            zsh.enable = true;
        };
    };

    mkHome = system: {
        name = "home-${system}";
        value = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
            extraSpecialArgs = { inherit inputs username; };
            modules =
                (lib.attrValues top.config.flake.modules.generic)
                ++ (lib.attrValues top.config.flake.modules.homeManager)
                ++ [ profile ];
        };
    };
in
{
    flake.homeConfigurations = lib.listToAttrs (map mkHome top.config.systems);
}
