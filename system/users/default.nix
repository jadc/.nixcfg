{ config, ... }:

let
    user = config.common.username;
in
{
    # Create user
    users.users = {
        ${user} = {
            isNormalUser = true;
            description = "${user}";
            extraGroups = [ "wheel" ];
        };
    };

    # Enable automatic login for the user.
    services.getty.autologinUser = "${user}";

    # Allow wheel group to skip sudo password
    security.sudo.wheelNeedsPassword = false;
}
