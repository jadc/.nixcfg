# The following home.nix is shared amongst all profiles
# You shouldn't need to modify this file.

{ config, lib, ... }:

{
    imports = [ ./options.common.nix ];

    home = {
        username = lib.mkForce config.common.username;
        homeDirectory = lib.mkForce ("/home/" + config.common.username);
        stateVersion = "24.05";  # Do not need to update
    };

    # Automatically start systemd user services
    systemd.user.startServices = true;

    # Use xdg user directories
    xdg.enable = true;
    xdg.configFile."mimeapps.list".force = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Allow unfree packages in nix shells
    xdg.configFile."nixpkgs/config.nix".text = ''{ allowUnfree = true; }'';
}
