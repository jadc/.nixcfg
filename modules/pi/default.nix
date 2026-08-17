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

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            programs.pi-coding-agent = {
                enable = true;
                extraPackages = [ pkgs.nodejs_latest ];
            };

            # Copy configuration as r+w without deleting files created by pi.
            home.activation.piFiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                run ${pkgs.rsync}/bin/rsync \
                    -a --chmod=Du+w,Fu+w --checksum --no-owner --no-group \
                    ${./config}/ "$HOME/"
            '';

            cfg.save.home.dirs = [ ".pi" ];
        };
    };
}
