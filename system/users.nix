{ config, pkgs, ... }:

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

    # Set default shell to zsh for all users
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;

    # Allow wheel group to skip sudo password
    security.sudo.wheelNeedsPassword = false;
}
