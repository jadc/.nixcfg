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

    flake.modules.nixos.${name} = { config, lib, username, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            services.syncthing = {
                enable = true;
                openDefaultPorts = true;
                user = username;
                group = "wheel";
            };
        };
    };
}
