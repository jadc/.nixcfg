{ pkgs, ... }:

{
    # Create user
    users.users = {
        jad = {
            isNormalUser = true;
            description = "jad";
            extraGroups = [ "wheel" ];
        };
    };

    # Enable automatic login for the user.
    services.getty.autologinUser = "jad";

    # Set default shell to zsh for all users
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;
}
