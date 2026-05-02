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
            # Enable virtualbox
            virtualisation.virtualbox.host.enable = true;

            # Create virtualbox group
            users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

            # Add user to virtualbox group
            users.users.${username}.extraGroups = [ "vboxusers" ];

            # Guest additions
            virtualisation.virtualbox.guest.enable = true;
            virtualisation.virtualbox.guest.dragAndDrop = true;
        };
    };
}
