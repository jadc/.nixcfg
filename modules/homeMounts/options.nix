{ lib, ... }:

let
    name = "homeMounts";
in
{
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
}
