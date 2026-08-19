{ inputs, ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.homeManager.${name} = {
        imports = [ inputs.pi.homeManagerModules.default ];

        cfg.save.home.dirs = [ ".pi" ];
    };
}
