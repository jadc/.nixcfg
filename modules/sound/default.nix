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

    flake.modules.nixos.${name} = { config, lib, pkgs, username, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            security.rtkit.enable = true;
            services.pipewire = {
                enable = true;
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
            };

            environment.systemPackages = [ pkgs.pipewire.jack ];

            # Add user to audio group
            users.users.${username}.extraGroups = [ "audio" ];
        };
    };
}
