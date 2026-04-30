{ config, lib, username, ... }:

let
    name = "virtualbox";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

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
}
