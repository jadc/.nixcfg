{ config, lib, ... }:

let
    name = "users";
    self = config.cfg.system.${name};
    user = config.common.username;
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
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
    };
}
