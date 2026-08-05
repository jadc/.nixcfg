top@{ inputs, lib, ... }:

let
    username = "jad";

    mkHome = system: {
        name = "work-${system}";
        value = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
            extraSpecialArgs = { inherit inputs username; };
            modules =
                (lib.attrValues top.config.flake.modules.generic)
                ++ (lib.attrValues top.config.flake.modules.homeManager)
                ++ [ ../_common/work.nix ];
        };
    };
in
{
    flake.homeConfigurations = lib.listToAttrs (map mkHome top.config.systems);
}
