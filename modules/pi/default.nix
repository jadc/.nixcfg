{ inputs, ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.homeManager.${name} = {
        imports = [ inputs.pi.homeManagerModules.default ];

        cfg.save.home.dirs = [ ".pi" ];
        cfg.const.aliases.pi = "command pi update --extensions && command pi";
    };
}
