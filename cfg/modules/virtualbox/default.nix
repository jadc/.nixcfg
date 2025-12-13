{ config, lib, ... }:

let
    name = "virtualbox";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # Enable virtualbox
        virtualisation.virtualbox.host.enable = true;

        # Create virtualbox group
        users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

        # Add user to virtualbox group
        users.users.${config.cfg.const.username}.extraGroups = [ "vboxusers" ];

        # Guest additions
        virtualisation.virtualbox.guest.enable = true;
        virtualisation.virtualbox.guest.dragAndDrop = true;
    };
}
