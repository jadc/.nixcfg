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

    flake.modules.homeManager.${name} = { config, lib, inputs, ... }: let self = config.cfg.${name}; in {
        imports = [ inputs.helium.homeModules.default ];

        config = lib.mkIf self.enable {
            programs.${name} = {
                enable = true;
                flags = [ "--disable-features=WebRtcAllowInputVolumeAdjustment" ];
            };

            cfg.save.home.dirs = [
                ".config/net.imput.helium"
                ".cache/net.imput.helium"
            ];
        };
    };
}
