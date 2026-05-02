{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;

            source = lib.mkOption {
                type = lib.types.str;
                default = "/data";
                description = "Directory whose entries will be bind-mounted into the user's home.";
            };

            dirs = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [ ];
                description = "Names under `source` to bind-mount into ~ with the same name.";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, username, ... }:
    let
        self = config.cfg.${name};
        home = "/home/${username}";
    in {
        config = lib.mkIf self.enable {
            fileSystems = lib.listToAttrs (map (n: {
                name = "${home}/${n}";
                value = {
                    device = "${self.source}/${n}";
                    fsType = "none";
                    options = [ "bind" ];
                };
            }) self.dirs);
        };
    };
}
