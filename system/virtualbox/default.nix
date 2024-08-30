{ config, ... }:

{
    # Enable virtualbox
    virtualisation.virtualbox.host.enable = true;

    # Create virtualbox group
    users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

    # Add user to virtualbox group
    users.users.${config.common.username}.extraGroups = [ "vboxusers" ];

    # Guest additions
    virtualisation.virtualbox.guest.enable = true;
    virtualisation.virtualbox.guest.dragAndDrop = true;
}
