{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { config, lib, pkgs, ... }: let
        agreety = pkgs.symlinkJoin {
            name = "agreety";
            paths = [ pkgs.greetd ];
            meta.mainProgram = "agreety";
        };
    in {
        options.cfg.${name} = {
            package = lib.mkOption {
                type = lib.types.package;
                default = agreety;
                description = "Package providing the greetd greeter executable.";
            };

            command = lib.mkOption {
                type = lib.types.str;
                default = lib.getExe config.cfg.${name}.package;
                readOnly = true;
                description = "Absolute path to the configured greeter executable.";
            };

            extraArgs = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [];
                description = "Additional arguments passed to the greeter.";
            };
        };
    };
}
